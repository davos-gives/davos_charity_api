defmodule DavosCharityApi.Organization do
  use Ecto.Schema
  import Ecto.Changeset
  alias DavosCharityApi.Repo

  alias DavosCharityApi.Organization
  alias DavosCharityApi.Fundraising.Campaign
  alias DavosCharityApi.Donor.DonorOrganizationRelationship
  alias DavosCharityApi.Donor

  import Ecto.Query

  schema "organizations" do
    field :name, :string
    field :logo, :string
    field :facebook_handle, :string
    field :twitter_handle, :string
    field :instagram_handle, :string

    has_many :campaigns, Campaign
    has_many :donor_organization_relationships, DonorOrganizationRelationship
    timestamps()
  end

  def changeset(%Organization{} = model, attrs) do
    model
    |> cast(attrs, [:name, :logo])
    |> validate_required([:name, :logo])
  end

  def get_organization!(id), do: Repo.get!(Organization, id)

  def create_organization(attrs \\ %{}) do
    %Organization{}
    |> Organization.changeset(attrs)
    |> Repo.insert
  end

  def get_organization_for_relationship!(relationship_id) do
    relationship = Donor.get_donor_organization_relationship!(relationship_id)
    relationship = Repo.preload(relationship, :organization)
    relationship.organization
  end
end
