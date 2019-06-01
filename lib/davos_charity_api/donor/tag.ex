defmodule DavosCharityApi.Donor.Tag do
  use Ecto.Schema
  import Ecto.Changeset

  alias DavosCharityApi.Donor
  alias DavosCharityApi.Donor.Tag

  import IEx

  schema "tags" do
    field :name, :string
    many_to_many :donors, Donor, join_through: "donor_tags", on_replace: :mark_as_invalid
    timestamps()
  end

  def changeset(%Tag{} = model, attrs) do
    model
    |> cast(attrs, [:name])
    |> validate_required([])

  end
end
