defmodule DavosCharityApi.Organization do
  use Ecto.Schema
  import Ecto.Changeset
  alias DavosCharityApi.Repo

  alias DavosCharityApi.Organization
  alias DavosCharityApi.Fundraising.Campaign
  alias DavosCharityApi.Donor.DonorOrganizationRelationship

  import Ecto.Query

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

  def create_organization(attrs \\ %{}) do
    %Organization{}
    |> Organization.changeset(attrs)
    |> Repo.insert
  end
 end
