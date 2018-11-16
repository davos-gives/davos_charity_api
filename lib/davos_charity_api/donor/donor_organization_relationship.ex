defmodule DavosCharityApi.Donor.DonorOrganizationRelationship do
  use Ecto.Schema
  import Ecto.Changeset

  alias DavosCharityApi.Donor
  alias DavosCharityApi.Organization
  alias DavosCharityApi.Donor.DonorOrganizationRelationship
  alias DavosCharityApi.Donation.Ongoing
  alias DavosCharityApi.Donation.Payment

  schema "donor_organization_relationships" do
    belongs_to :donor, Donor
    belongs_to :organization, Organization
    has_many :ongoing_donations, Ongoing
  end

  def changeset(%DonorOrganizationRelationship{} = model, attrs) do
    model
    |> cast(attrs, [:donor_id, :organization_id])
    |> validate_required([:donor_id, :organization_id])
  end
end
