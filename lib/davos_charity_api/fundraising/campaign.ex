defmodule DavosCharityApi.Fundraising.Campaign do
  use Ecto.Schema
  use Decoratex.Schema

  import Ecto.Changeset

  alias DavosCharityApi.Fundraising.Campaign
  alias DavosCharityApi.Fundraising.Form
  alias DavosCharityApi.Fundraising.Template
  alias DavosCharityApi.Donation.Payment
  alias DavosCharityApi.Fundraising
  alias DavosCharityApi.Organization

  decorations do
    decorate_field :total_donations, :integer, &Fundraising.get_total_donations/1
    decorate_field :number_of_donors, :integer, &Fundraising.get_number_of_donors/1
  end

  schema "charity_fundraising_campaigns" do
    field :name, :string
    field :type, :string
    field :status, :string
    field :image, :string

    field :description, :string
    field :has_end_date, :boolean, default: false
    field :go_back_url, :string
    field :image_url, :string
    field :logo_url, :string
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
    decorations()
  end

  def changeset(%Campaign{} = model, attrs) do
    model
    |> cast(attrs, [:name, :type, :status, :organization_id, :description, :has_end_date, :go_back_url, :image_url, :font, :end_date, :end_month, :end_year, :primary_colour, :secondary_colour, :tertiary_colour, :quaternary_colour, :quinary_colour, :facebook_share, :twitter_share, :email_share, :linkedin_share, :published])
    |> cast(attrs, [:show_goal, :has_goal, :goal, :logo_url, :template_id])
    |> validate_required([])
  end
end
