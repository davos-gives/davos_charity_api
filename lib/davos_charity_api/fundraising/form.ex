defmodule DavosCharityApi.Fundraising.Form do
  use Ecto.Schema
  import Ecto.Changeset

  alias DavosCharityApi.Fundraising.Campaign
  alias DavosCharityApi.Fundraising.Form


  schema "forms" do
    field :name, :string
    field :description, :string
    field :goal, :integer
    field :end_date, :string
    field :go_back_url, :string
    field :font, :string
    field :size, :string
    field :colour, :string

    field :status, :string
    belongs_to :campaign, Campaign

    timestamps()
  end

  def changeset(%Form{} = model, attrs) do
    model
    |> cast(attrs, [:name, :description, :goal, :end_date, :go_back_url, :font, :size, :colour, :campaign_id, :status])
    |> validate_required([:name, :description, :status])
  end
end
