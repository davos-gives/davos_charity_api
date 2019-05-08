defmodule DavosCharityApi.Donor.VaultCard do
  use Ecto.Schema
  import Ecto.Changeset

  alias DavosCharityApi.Donor
  alias DavosCharityApi.Donor.VaultCard
  alias DavosCharityApi.Donor.Vault
  alias DavosCharityApi.Donation.Ongoing

  schema "donor_vault_card" do
    field :iats_id, :string
    field :name, :string
    field :last_four_digits, :string
    field :card_type, :string
    field :primary, :boolean
    field :expiry_month, :string
    field :expiry_year, :string
    belongs_to :vault, Vault
    belongs_to :donor, Donor
    has_many :ongoing_donations, Ongoing


    timestamps()
  end

  def changeset(%VaultCard{} = model, attrs) do
    model
    |> cast(attrs, [:iats_id, :name, :vault_id, :donor_id, :primary, :expiry_month, :expiry_year, :card_type, :last_four_digits, :ongoing_donation_id])
    |> validate_required([:iats_id, :name, :vault_id, :donor_id])
  end
end
