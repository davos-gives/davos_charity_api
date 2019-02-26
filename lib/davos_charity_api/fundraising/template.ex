defmodule DavosCharityApi.Fundraising.Template do
  use Ecto.Schema
  import Ecto.Changeset

  alias DavosCharityApi.Fundraising.Template

  schema "templates" do
    field :name, :string
    field :description, :string
    field :goal, :integer
    field :end_date, :string
    field :end_month, :string
    field :end_year, :string
    field :go_back_url, :string
    field :font, :string
    field :size, :string
    field :colour, :string
    field :facebook_share, :string
    field :linkedin_share, :string
    field :twitter_share, :string
    field :email_share, :string
    timestamps()
  end

  def changeset(%Template{} = model, attrs) do
    model
    |> cast(attrs, [:name, :description, :goal, :end_date, :end_month, :end_year, :go_back_url, :font, :size, :colour, :facebook_share, :twitter_share, :email_share, :linkedin_share])
    |> validate_required([:name, :description])
  end
end
