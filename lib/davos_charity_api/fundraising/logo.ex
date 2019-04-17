defmodule DavosCharityApi.Fundraising.Logo do
  use Ecto.Schema
  import Ecto.Changeset

  alias DavosCharityApi.Fundraising.Logo

  schema "logos" do
    field :url, :string
    field :category, :string
    timestamps()
  end

  def changeset(%Logo{} = model, attrs) do
    model
    |> cast(attrs, [:url, :category])
    |> validate_required([:url])
  end
end
