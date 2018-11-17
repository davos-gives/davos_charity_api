defmodule DavosCharityApi.Donation do

  alias DavosCharityApi.Repo
  alias DavosCharityApi.Donation.Ongoing
  alias DavosCharityApi.Donation.Payment
  alias DavosCharityApi.Donation

  import Ecto.Query

  def get_ongoing_donation!(id), do: Repo.get!(Ongoing, id)

  def create_ongoing_donation(attrs \\ %{}) do
    %Ongoing{}
    |> Ongoing.changeset(attrs)
    |> Repo.insert
  end

  def list_ongoing_donations() do
    Ongoing
    |> Repo.all
  end

  def list_ongoing_donations_for_donor(donor_id) do
    Ongoing
    |> where([og], og.donor_id == ^donor_id)
    |> Repo.all
  end

  def list_ongoing_donations_for_relationship(relationship_id) do
    Ongoing
    |> where([og], og.donor_organization_relationship_id == ^relationship_id)
    |> Repo.all
  end

  def update_ongoing_donation(%Ongoing{} = ongoing, attrs) do
    ongoing
    |> Ongoing.changeset(attrs)
    |> Repo.update
  end

  def delete_ongoing_donation(%Ongoing{} = model), do: Repo.delete(model)

  def get_donor_for_ongoing_donation!(ongoing_donation_id) do
    donation = Donation.get_ongoing_donation!(ongoing_donation_id)
    donation = Repo.preload(donation, :donor)
    donation.donor
  end

  def get_payment_method_for_ongoing_donation(ongoing_donation_id) do
    donation = Donation.get_ongoing_donation!(ongoing_donation_id)
    donation = Repo.preload(donation, :payment_method)
    donation.payment_method
  end

  def get_campaign_for_ongoing_donation(ongoing_donation_id) do
    donation = Donation.get_ongoing_donation!(ongoing_donation_id)
    donation = Repo.preload(donation, :campaign)
    donation.campaign
  end

  def get_payment!(id), do: Repo.get!(Payment, id)

  def list_payments(), do: Repo.all(Payment)

  def list_payments_for_donor(donor_id) do
    Payment
    |> where([pm], pm.donor_id == ^donor_id)
    |> Repo.all
  end

  def list_payments_for_relationship(relationship_id) do
    Payment
    |> where([pm], pm.donor_organization_relationship_id == ^relationship_id)
    |> Repo.all
  end

  def create_payment(attrs \\ %{}) do
    %Payment{}
    |> Payment.changeset(attrs)
    |> Repo.insert
  end

  def get_relationship_for_ongoing_donation(ongoing_donation_id) do
    donation = Donation.get_ongoing_donation!(ongoing_donation_id)
    donation = Repo.preload(donation, :donor_organization_relationship)
    donation.donor_organization_relationship |> Repo.preload(:payments)
  end

  def get_relationship_for_payment(payment_id) do
    payment = Donation.get_payment!(payment_id)
    payment = Repo.preload(payment, :donor_organization_relationship)
    payment.donor_organization_relationship
  end

  def get_campaign_for_payment(payment_id) do
    payment = Donation.get_payment!(payment_id)
    payment = Repo.preload(payment, :campaign)
    payment.campaign
  end
end
