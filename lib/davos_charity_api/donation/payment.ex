defmodule DavosCharityApi.Donation.Payment do
  use Ecto.Schema
  import Ecto.Changeset

  alias DavosCharityApi.Donor
  alias DavosCharityApi.Donation.Ongoing
  alias DavosCharityApi.Donation.Payment
  alias DavosCharityApi.Fundraising.Form
  alias DavosCharityApi.Fundraising.Campaign

  schema "donation_payment" do
    field :frequency, :string
    field :status, :string
    field :amount, :string

    belongs_to :donor, Donor
    belongs_to :ongoing_donation, Ongoing
    belongs_to :campaign, Campaign
    timestamps()
  end

  def changeset(%Payment{} = model, attrs) do
    model
    |> cast(attrs, [:frequency, :status, :amount, :donor_id, :ongoing_donation_id, :campaign_id])
    |> validate_required([:frequency, :status, :amount, :donor_id, :campaign_id])
  end
end
