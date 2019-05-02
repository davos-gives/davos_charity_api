defmodule DavosCharityApi.Donation do

  import Ecto.Query
  import Exiats
  import IEx

  alias DavosCharityApi.Repo
  alias DavosCharityApi.Donation.Ongoing
  alias DavosCharityApi.Donation.Payment
  alias DavosCharityApi.Donation
  alias DavosCharityApi.Fundraising.Campaign
  alias DavosCharityApi.Donor.DonorHistory

  alias Exiats.Owner
  alias Exiats.OngoingDonation
  alias Exiats.OngoingChanges

  alias Ecto.Multi

  def get_ongoing_donation!(id), do: Repo.get!(Ongoing, id)

  def create_ongoing_donation(attrs \\ %{}) do
    response = Multi.new()
    |> format_data_for_iats(attrs)
    |> submit_data_to_iats(attrs)
    |> create_ongoing_donation_in_db(attrs)
    |> create_ongoing_payment(attrs)
    |> Repo.transaction()
  end

  def update_ongoing_donation(%Ongoing{} = ongoing, attrs = %{"status" => "cancelled"}) do
    ongoing
    |> Ongoing.changeset(attrs)
    |> Repo.update
  end

  def update_ongoing_donation(%Ongoing{} = ongoing, attrs) do
    ongoing
    |> Ongoing.changeset(attrs)
    |> Repo.update
  end

  def cancel_ongoing_donation(ongoing, attrs \\ %{}) do
    ongoing_changes = %OngoingChanges{
      status: "0",
      amount: "10.00"
    }
    payment = Exiats.recurring_modify(attrs["reference_number"], ongoing_changes)
  end

  def create_donation(attrs \\ %{}) do
    response = Multi.new()
    |> format_data_for_iats(attrs)
    |> submit_data_to_iats(attrs)
    |> create_donation_history(attrs)
    |> create_payment(attrs)
    |> Repo.transaction
  end

  def create_vault_donation(attrs \\ %{}) do
    response = Multi.new()
    |> format_data_for_iats(attrs)
    |> submit_vault_data_to_iats(attrs)
    |> create_donation_history(attrs)
    |> create_payment(attrs)
    |> Repo.transaction
  end

  def create_ongoing_vault_donation(attrs \\ %{}) do
    response = Multi.new()
    |> format_data_for_iats(attrs)
    |> submit_vault_data_to_iats(attrs)
    |> create_ongoing_donation_in_db(attrs)
    |> create_ongoing_payment(attrs)
    |> Repo.transaction
  end

  def create_ongoing_donation_in_db(multi, attrs) do
    Multi.run(multi, :created_ongoing_donation, fn repo, %{submitted_data: submitted_data} ->
      ongoingDonation = %{
        frequency: "weekly",
        amount: attrs["amount"],
        donor_id: attrs["donor_id"],
        status: "active",
        campaign_id: attrs["campaign_id"],
        reference_number: submitted_data["data"]["referenceNumber"],
      }

      new_ongoing = %Ongoing{}
      |> Ongoing.changeset(ongoingDonation)
      |> repo.insert

      new_ongoing
    end)
  end

  def create_payment(multi, attrs) do
    Multi.run(multi, :created_payment, fn repo, %{submitted_data: submitted_data} ->
      payment = %{
        amount: to_integer(submitted_data["data"]["originalFullAmount"]),
        frequency: "one-time",
        reference_number: submitted_data["data"]["referenceNumber"],
        donor_id: attrs["donor_id"],
        campaign_id: attrs["campaign_id"]
      }
      new_payment = %Payment{}
      |> Payment.changeset(payment)
      |> repo.insert

      {:ok, new_payment}
    end)
  end

  def create_ongoing_payment(multi, attrs) do
    Multi.run(multi, :created_payment, fn repo, %{submitted_data: submitted_data, created_ongoing_donation: created_ongoing_donation} ->
      payment = %{
        amount: to_integer(submitted_data["data"]["originalFullAmount"]),
        frequency: "one-time",
        reference_number: submitted_data["data"]["referenceNumber"],
        donor_id: attrs["donor_id"],
        campaign_id: attrs["campaign_id"],
        ongoing_donation_id: created_ongoing_donation.id,
      }
      new_payment = %Payment{}
      |> Payment.changeset(payment)
      |> repo.insert

      {:ok, new_payment}
    end)
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

  def delete_ongoing_donation(%Ongoing{} = model), do: Repo.delete(model)

  def get_donor_for_ongoing_donation!(ongoing_donation_id) do
    donation = Donation.get_ongoing_donation!(ongoing_donation_id)
    donation = Repo.preload(donation, :donor)
    donation.donor
  end

  def get_donor_for_payment!(payment_id) do
    donation = Donation.get_payment!(payment_id)
    donation = Repo.preload(donation, :donor)
    donation.donor
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

  def list_payments_for_campaign(campaign_id) do
    Payment
    |> where([pm], pm.campaign_id == ^campaign_id)
    |> Repo.all
  end

  def list_payments_for_relationship(relationship_id) do
    Payment
    |> where([pm], pm.donor_organization_relationship_id == ^relationship_id)
    |> Repo.all
  end

  defp format_data_for_iats(multi, attrs) do
    Multi.run(multi, :formatted_data, fn _repo, %{} ->
      owner = %Owner{
          name: "Ian Knauer",
          street: "123 Fake Street",
          city: "Vancouver",
          province: "BC",
          country: "Canada",
          postal_code: "V3H4X9"
        }
      {:ok, owner}
    end)
  end

  defp submit_vault_data_to_iats(multi, attrs = %{"frequency" => "one-time"}) do
    Multi.run(multi, :submitted_data, fn _repo, %{formatted_data: formatted_data} ->
      payment = Exiats.vault_sale(attrs["vault_id"], attrs["vault_key"], Float.to_string(attrs["amount"] / 100), formatted_data)
      {:ok, payment }
    end)
  end

  defp submit_vault_data_to_iats(multi, attrs) do
    Multi.run(multi, :submitted_data, fn _repo, %{formatted_data: formatted_data} ->
      ongoing = %OngoingDonation{
        frequency: attrs["frequency"],
      }
      payment = Exiats.vault_sale(attrs["vault_id"], attrs["vault_key"], ongoing, Float.to_string(attrs["amount"] / 100), formatted_data)
      {:ok, payment }
    end)
  end

  defp submit_data_to_iats(multi, attrs = %{"frequency" => "one-time"}) do
    Multi.run(multi, :submitted_data, fn _repo, %{formatted_data: formatted_data} ->
      payment = Exiats.sale(Float.to_string(attrs["amount"] / 100), formatted_data, attrs["cryptogram"])
      {:ok, payment }
    end)
  end

  defp submit_data_to_iats(multi, attrs = %{"frequency" => _frequency}) do
    Multi.run(multi, :submitted_data, fn _repo, %{formatted_data: formatted_data} ->
      ongoing = %OngoingDonation{
        frequency: attrs["frequency"],
      }
      payment = Exiats.sale(Float.to_string(attrs["amount"] / 100), formatted_data, ongoing, attrs["cryptogram"])
      {:ok, payment }
    end)
  end

  def create_donation_history(multi, attrs) do
    Multi.run(multi, :created_history, fn repo, %{} ->
      history = %{
        amount: attrs["amount"],
        status: "success",
        history_type: "payment",
        frequency: "one-time",
        donor_id: attrs["donor_id"],
      }
      new_history= %DonorHistory{}
      |> DonorHistory.changeset(history)
      |> repo.insert
    end)
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

  def to_integer(value) do
    value
    |> Decimal.from_float()
    |> Decimal.mult(Decimal.new(100))
    |> Decimal.round(0)
    |> Decimal.to_integer()
  end
end
