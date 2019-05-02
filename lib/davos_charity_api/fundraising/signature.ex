defmodule DavosCharityApi.Fundraising.Signature do
  use Ecto.Schema
  import Ecto.Changeset

  alias DavosCharityApi.Fundraising.Signature

  schema "signatures" do
    field :url, :string
    field :category, :string
    timestamps()
  end

  def changeset(%Signature{} = model, attrs) do
    model
    |> cast(attrs, [:url, :category])
    |> validate_required([:url])
  end
end
