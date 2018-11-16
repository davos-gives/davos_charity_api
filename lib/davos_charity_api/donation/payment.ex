defmodule DavosCharityApi.Donation.Payment do
  use Ecto.Schema
  import Ecto.Changeset

  alias DavosCharityApi.Donor
  alias DavosCharityApi.Donation.Ongoing
  alias DavosCharityApi.Donation.Payment
  alias DavosCharityApi.Fundraising.Campaign
  alias DavosCharityApi.Donor.DonorOrganizationRelationship

  schema "donation_payments" do
    field :amount, :integer

    belongs_to :donor, Donor
    belongs_to :ongoing_donation, Ongoing
    belongs_to :campaign, Campaign
    belongs_to :donor_organization_relationship, DonorOrganizationRelationship
    timestamps()
  end

  def changeset(%Payment{} = model, attrs) do
    model
    |> cast(attrs, [:amount, :donor_id, :ongoing_donation_id, :campaign_id, :donor_organization_relationship_id])
    |> validate_required([:amount, :donor_id, :campaign_id,  :donor_organization_relationship_id])
  end
end
