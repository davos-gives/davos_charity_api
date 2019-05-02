defmodule DavosCharityApi.Donor do
  use Ecto.Schema

  import Ecto.Changeset
  import Ecto.Query

  alias Comeonin.Bcrypt
  alias Ecto.Multi


  alias DavosCharityApi.Repo
  alias DavosCharityApi.Donor
  alias DavosCharityApi.Donor.{Address, DonorOrganizationRelationship, DonorHistory, Vault, VaultCard}

  alias DavosCharityApi.Donation
  alias DavosCharityApi.Donation.Ongoing
  alias DavosCharityApi.Donation.Payment

  import Ecto.Query
  import Exiats
  import IEx

  schema "donors" do
    field :email, :string
    field :fname, :string
    field :lname, :string
    field :password_hash, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    field :verified, :boolean, default: false

    has_many :addresses, Address
    has_many :ongoing_donations, Ongoing
    has_many :payments, Payment
    has_many :donor_organization_relationships, DonorOrganizationRelationship
    has_many :vaults, Vault
    has_many :vault_cards, VaultCard
    timestamps()
  end

  def hash_password(changeset=%{valid?: false}), do: changeset

  def hash_password(changeset) do
    hash = Bcrypt.hashpwsalt(get_field(changeset, :password))
    put_change(changeset, :password_hash, hash)
  end

  @doc false

  def changeset(%Donor{} = donor, attrs = %{reset: _}) do

    donor
    |> cast(attrs, [:password, :password_confirmation])
    |> validate_confirmation(:password, message: "confirmation does not match password")
    |> hash_password()
  end

  def changeset(donor, attrs = %{"password" => _, "password_confirmation" => _}) do
    donor
    |> cast(attrs, [:fname, :lname, :email, :password, :password_confirmation, :verified])
    |> validate_required([:fname, :lname, :email, :password, :password_confirmation])
    |> validate_confirmation(:password, message: "confirmation does not match password")
    |> validate_format(:email, ~r/@/)
    |> unsafe_validate_unique([:email], DavosCharityApi.Repo)
    |> hash_password()
  end

  def changeset(donor, attrs = %{"password" => _, }) do
    donor
    |> cast(attrs, [:fname, :lname, :email, :password, :verified])
    |> validate_required([:fname, :lname, :email, :password])
    |> validate_format(:email, ~r/@/)
    |> unsafe_validate_unique([:email], DavosCharityApi.Repo)
    |> hash_password()
  end

  def changeset(donor, attrs) do
    donor
    |> cast(attrs, [:fname, :lname, :email, :password, :verified])
    |> validate_required([])
    |> unsafe_validate_unique([:email], DavosCharityApi.Repo)
  end

  def list_donors, do: Repo.all(Donor)

  def get_donor!(id) do
    donor = Repo.get!(Donor, id)
    donor = Repo.preload(donor, [:vaults, :addresses, :vault_cards])
  end

  def get_donor_by_email!(email), do: Repo.get_by!(Donor, email: email)

  def create_donor(attrs \\ %{}) do
    %Donor{}
    |> Donor.changeset(attrs)
    |> Repo.insert
  end

  def update_donor(%Donor{} = donor, attrs) do
    donor
    |> Donor.changeset(attrs)
    |> Repo.update
  end

  def mark_account_as_verified(%Donor{} = donor) do
    donor
    |> Donor.changeset(%{verified: true})
    |> Repo.update
  end

  def get_address!(id), do: Repo.get!(Address, id)

  def get_donor_for_address!(address_id) do
    address = Donor.get_address!(address_id)
    address = Repo.preload(address, :donor)
    address.donor
  end

  def create_address(attrs \\ %{}) do
    %Address{}
    |> Address.changeset(attrs)
    |> Repo.insert
  end

  def update_address(%Address{} = address, attrs) do
    address
    |> Address.changeset(attrs)
    |> Repo.update
  end

  def list_addresses_for_donor(donor_id) do
    Address
    |> where([a], a.donor_id == ^donor_id)
    |> Repo.all
  end

  def get_donor_organization_relationship!(id) do
    relationship = Repo.get!(DonorOrganizationRelationship, id)
    |> Repo.preload(:payments)
  end

  def create_donor_organization_relationship(attrs \\ %{}) do
    %DonorOrganizationRelationship{}
    |> DonorOrganizationRelationship.changeset(attrs)
    |> Repo.insert()
  end

  def get_donor_for_relationship!(relationship_id) do
    relationship = Donor.get_donor_organization_relationship!(relationship_id)
    relationship = Repo.preload(relationship, :donor)
    relationship.donor
  end

  def list_donor_history, do: Repo.all(DonorHistory)

  def list_history_for_donor(donor_id) do
    DonorHistory
    |> where([dh], dh.donor_id == ^donor_id)
    |> Repo.all
  end

  def list_cards_for_donor(donor_id) do
    VaultCard
    |> where([vc], vc.donor_id == ^donor_id)
    |> Repo.all
  end

  def initialize_and_create_vault(attrs \\ %{}) do
    Multi.new()
    |> send_iats_vault_creation
    |> create_vault(attrs)
    |> Repo.transaction
  end

  def get_vault_for_donor(donor_id) do
    Vault
    |> where([vault], vault.donor_id == ^donor_id)
    |> Repo.all
  end

  def get_cards_for_vault(vault_id) do
    VaultCard
    |> where([card], card.vault_id == ^vault_id)
    |> Repo.all
  end

  defp send_iats_vault_creation(multi) do
    Multi.run(multi, :created_vault, fn _repo, %{} ->
      vault = Exiats.create_vault_for_donor()
      {:ok, vault}
    end)
  end

  defp create_vault(multi, attrs) do
    Multi.run(multi, :final, fn repo, %{created_vault: created_vault} ->
      vault = %{
        iats_id: created_vault["data"]["vaultKey"],
        donor_id: attrs.donor_id
      }
      %Vault{}
      |> Vault.changeset(vault)
      |> repo.insert
    end)
  end

  def add_credit_card_to_vault(attrs \\ %{}) do
    Multi.new()
    |> send_iats_vault_card_creation(attrs)
    |> get_iats_vault_card_information(attrs)
    |> create_vault_card(attrs)
    |> Repo.transaction
  end

  defp send_iats_vault_card_creation(multi, attrs) do
    Multi.run(multi, :added_card, fn _repo, %{} ->
      card = Exiats.add_card_to_vault(attrs["vault_key"], attrs["crypto"])
      {:ok, card}
    end)
  end

  defp get_iats_vault_card_information(multi, attrs) do
    Multi.run(multi, :added_card_info, fn _repo, %{added_card: added_card} ->
      card = Exiats.get_vault_card(attrs["vault_key"], Integer.to_string(added_card["data"]["id"]))
      {:ok, card}
    end)
  end

  defp create_vault_card(multi, attrs) do
    Multi.run(multi, :final, fn repo, %{added_card_info: added_card_info} ->
      card = %{
        donor_id: attrs["donor_id"],
        vault_id: attrs["vault_id"],
        name: attrs["name"],
        card_type: added_card_info["cardType"],
        last_four_digits: added_card_info["cardNoLast4"],
        iats_id: Integer.to_string(added_card_info["id"]),
        expiry_month: added_card_info["cardExpMM"],
        expiry_year: added_card_info["cardExpYY"]
      }

      newVaultCard = %VaultCard{}
      |> VaultCard.changeset(card)
      |> repo.insert

      {:ok, newVaultCard}
    end)
  end
end
