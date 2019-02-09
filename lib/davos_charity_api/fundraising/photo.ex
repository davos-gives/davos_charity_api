defmodule DavosCharityApi.Fundraising.Photo do
  use Ecto.Schema
  import Ecto.Changeset

  alias DavosCharityApi.Fundraising.Photo

  schema "photos" do
    field :url, :string
    field :category, :string
    timestamps()
  end

  def changeset(%Photo{} = model, attrs) do
    model
    |> cast(attrs, [:url, :category])
    |> validate_required([:url])
  end
end
