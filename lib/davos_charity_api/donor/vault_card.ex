defmodule DavosCharityApi.Donor.VaultCard do
  use Ecto.Schema
  import Ecto.Changeset

  alias DavosCharityApi.Donor
  alias DavosCharityApi.Donor.VaultCard
  alias DavosCharityApi.Donor.Vault

  schema "donor_vault_card" do
    field :iats_id, :string
    field :name, :string
    field :last_four_digits, :string
    field :card_type, :string
    field :primary, :boolean
    belongs_to :vault, Vault
    belongs_to :donor, Donor

    timestamps()
  end

  def changeset(%VaultCard{} = model, attrs) do
    model
    |> cast(attrs, [:iats_id, :name, :vault_id, :donor_id, :primary])
    |> validate_required([:iats_id, :name, :vault_id, :donor_id])
  end
end
