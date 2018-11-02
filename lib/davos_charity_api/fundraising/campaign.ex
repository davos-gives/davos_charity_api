defmodule DavosCharityApi.Fundraising.Campaign do
  use Ecto.Schema
  import Ecto.Changeset

  alias DavosCharityApi.Fundraising.Campaign
  alias DavosCharityApi.Fundraising.Form
  alias DavosCharityApi.Organization


  schema "charity_fundraising_campaigns" do
    field :name, :string
    field :type, :string
    field :status, :string

    belongs_to :organization, Organization
    has_many :forms, Form
    timestamps()
  end

  def changeset(%Campaign{} = model, attrs) do
    model
    |> cast(attrs, [:name, :type, :status, :form_id, :organization_id])
    |> validate_required([:name, :type, :status, :form_id, :organization_id])
  end
end
