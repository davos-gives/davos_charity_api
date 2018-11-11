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

  def update_ongoing_donation(%Ongoing{} = ongoing, attrs) do
    ongoing
    |> Ongoing.changeset(attrs)
    |> Repo.update
  end

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

  def get_payment!(id), do: Repo.get!(Payment, id)

  def list_payments(), do: Repo.all(Payment)

  def list_payments_for_donor(donor_id) do
    Payment
    |> where([pm], pm.donor_id == ^donor_id)
    |> Repo.all
  end

  def create_payment(attrs \\ %{}) do
    %Payment{}
    |> Payment.changeset(attrs)
    |> Repo.insert
  end
end
