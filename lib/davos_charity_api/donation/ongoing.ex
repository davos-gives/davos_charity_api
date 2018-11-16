defmodule DavosCharityApi.Donation.Ongoing do
  use Ecto.Schema
  import Ecto.Changeset

  alias DavosCharityApi.Donor
  alias DavosCharityApi.Donor.PaymentMethod
  alias DavosCharityApi.Donation.Ongoing
  alias DavosCharityApi.Fundraising.Campaign
  alias DavosCharityApi.Donor.DonorOrganizationRelationship

  schema "donation_ongoing" do
    field :frequency, :string
    field :status, :string
    field :amount, :integer

    belongs_to :donor, Donor
    belongs_to :campaign, Campaign
    belongs_to :payment_method, PaymentMethod
    belongs_to :donor_organization_relationship, DonorOrganizationRelationship

    timestamps()
  end

  def changeset(%Ongoing{} = model, attrs) do
    model
    |> cast(attrs, [:frequency, :status, :amount, :donor_id, :payment_method_id, :campaign_id, :donor_organization_relationship_id])
    |> validate_required([:frequency, :status, :amount, :donor_id, :payment_method_id, :campaign_id, :donor_organization_relationship_id])
  end
end
