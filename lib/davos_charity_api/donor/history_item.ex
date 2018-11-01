defmodule DavosCharityApi.Donor.HistoryItem do
  use Ecto.Schema
  import Ecto.Changeset

  alias DavosCharityApi.Donor
  alias DavosCharityApi.Donor.HistoryItem
  alias DavosCharityApi.Donation.Payment
  alias DavosCharityApi.Donation.Ongoing

  schema "donor_history_item" do
    field :name, :string
    belongs_to :donor, Donor
    belongs_to :ongoing, Ongoing
    belongs_to :payment, Payment
    timestamps()
  end

  def changeset(%HistoryItem{} = model, attrs) do
    model
    |> cast(attrs, [:name, :type, :number, :expiry, :cvv, :donor_id])
    |> validate_required([:name, :type, :number, :expiry, :cvv, :donor_id])
  end
end
