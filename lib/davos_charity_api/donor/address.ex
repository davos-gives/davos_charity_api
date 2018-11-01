defmodule DavosCharityApi.Donor.Address do
  use Ecto.Schema
  import Ecto.Changeset

  alias DavosCharityApi.Donor
  alias DavosCharityApi.Donor.Address

  schema "donor_addresses" do
    field :name, :string
    field :address_1, :string
    field :address_2, :string
    field :postal_code, :string
    field :city, :string
    field :province, :string
    field :country, :string
    belongs_to :donor, Donor
    timestamps()
  end

  def changeset(%Address{} = model, attrs) do
    model
    |> cast(attrs, [:name, :address_1, :address_2, :postal_code, :city, :province, :country, :donor_id])
    |> validate_required([:name, :address_1, :postal_code, :city, :province, :country, :donor_id])
  end
end
