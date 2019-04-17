defmodule DavosCharityApi.Donor.Vault do
  use Ecto.Schema
  import Ecto.Changeset

  alias DavosCharityApi.Donor
  alias DavosCharityApi.Donor.Vault

  schema "donor_vault" do
    field :iats_id, :string
    belongs_to :donor, Donor
    timestamps()
  end

  def changeset(%Vault{} = model, attrs) do
    model
    |> cast(attrs, [:iats_id, :donor_id])
    |> validate_required([:iats_id, :donor_id])
  end
end
