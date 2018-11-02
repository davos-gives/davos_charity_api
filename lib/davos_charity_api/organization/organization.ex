defmodule DavosCharityApi.Organization do
  use Ecto.Schema
  import Ecto.Changeset

  alias DavosCharityApi.Organization
  alias DavosCharityApi.Fundraising.Campaign
  alias DavosCharityApi.Donor.DonorOrganizationRelationship

  schema "organizations" do
    field :name, :string
    field :logo, :string

    has_many :campaigns, Campaign
    has_many :donor_organization_relationships, DonorOrganizationRelationship
    timestamps()
  end

  def changeset(%Organization{} = model, attrs) do
    model
    |> cast(attrs, [:name, :logo])
    |> validate_required([:name, :logo])
  end
end
