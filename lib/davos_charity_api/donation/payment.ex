defmodule DavosCharityApi.Donation.Payment do
  use Ecto.Schema
  import Ecto.Changeset

  alias DavosCharityApi.Donor
  alias DavosCharityApi.Donation.Ongoing
  alias DavosCharityApi.Donation.Payment
  alias DavosCharityApi.Fundraising.Form
  alias DavosCharityApi.Fundraising.Campaign
  alias DavosCharityApi.Donor.DonorOrganizationRelationship
  alias DavosCharityApi.Receipt

  schema "donation_payments" do
    field :amount, :integer
    field :frequency, :string
    field :reference_number, :string
    field :cryptogram, :string, virtual: true
    field :source, :string

    belongs_to :donor, Donor
    belongs_to :ongoing_donation, Ongoing
    belongs_to :campaign, Campaign
    belongs_to :donor_organization_relationship, DonorOrganizationRelationship
    belongs_to :form, Form
    has_many :receipts, Receipt
    timestamps()
  end

  def changeset(%Payment{} = model, attrs) do
    model
    |> cast(attrs, [:amount, :frequency, :donor_id, :ongoing_donation_id, :campaign_id, :form_id, :donor_organization_relationship_id, :reference_number, :cryptogram, :source])
    |> validate_required([:amount, :frequency, :reference_number, :donor_id])
  end
end
