defmodule DavosCharityApi.Fundraising.Campaign do
  use Ecto.Schema
  import Ecto.Changeset

  alias DavosCharityApi.Fundraising.Campaign
  alias DavosCharityApi.Fundraising.Form
  alias DavosCharityApi.Fundraising.Template
  alias DavosCharityApi.Donation.Payment
  alias DavosCharityApi.Organization


  schema "charity_fundraising_campaigns" do
    field :name, :string
    field :type, :string
    field :status, :string
    field :image, :string

    field :description, :string
    field :has_end_date, :boolean, default: false
    field :go_back_url, :string
    field :image_url, :string
    field :font, :string
    field :end_date, :string
    field :end_month, :string
    field :end_year, :string
    field :primary_colour, :string
    field :secondary_colour, :string
    field :tertiary_colour, :string
    field :quaternary_colour, :string
    field :quinary_colour, :string
    field :facebook_share, :boolean, default: false
    field :linkedin_share, :boolean, default: false
    field :twitter_share, :boolean, default: false
    field :email_share, :boolean, default: false
    field :published, :boolean, default: false

    field :has_goal, :boolean, default: false
    field :show_goal, :boolean, default: false
    field :goal, :integer

    belongs_to :organization, Organization
    belongs_to :template, Template
    has_many :forms, Form
    has_many :payments, Payment
    timestamps()
  end

  def changeset(%Campaign{} = model, attrs) do
    model
    |> cast(attrs, [:name, :type, :status, :organization_id, :description, :has_end_date, :go_back_url, :image_url, :font, :end_date, :end_month, :end_year, :primary_colour, :secondary_colour, :tertiary_colour, :quaternary_colour, :quinary_colour, :facebook_share, :twitter_share, :email_share, :linkedin_share, :published, :template_id])
    |> cast(attrs, [:show_goal, :has_goal, :goal])
    |> validate_required([])
  end
end
