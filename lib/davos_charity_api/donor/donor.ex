defmodule DavosCharityApi.Donor do
  use Ecto.Schema

  import Ecto.Changeset
  import Ecto.Query

  alias Comeonin.Bcrypt
  alias Ecto.Multi


  alias DavosCharityApi.Repo
  alias DavosCharityApi.Donor
  alias DavosCharityApi.Donor.{Address, DonorOrganizationRelationship, DonorHistory, Vault, VaultCard, Tag}

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

    many_to_many :tags, Tag, join_through: "donor_tags", on_replace: :mark_as_invalid
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
  end

  def changeset_add_tags(donor, attrs) do
    IEx.pry()
    donor
    |> cast(attrs, [:fname, :lname, :email, :password, :verified])
    |> put_assoc(:tags, parse_tags(attrs))
  end

  defp parse_tags(params) do
    (params["tags"] || "")
    |> Enum.map(&get_or_insert_tag/1)
  end

  defp get_or_insert_tag(name) do
    IEx.pry

    tag = Repo.insert!(%Tag{name: name}, on_conflict: :nothing)
  end

  def list_donors do
    Donor
    |> order_by(desc: :updated_at)
    |> Repo.all
  end

  def search_donors(search_term) do
    search_term = String.downcase(search_term)

    Donor
    |> where([a], like(fragment("lower(?)", a.fname), ^"%#{search_term}%"))
    |> or_where([a], like(fragment("lower(?)", a.lname), ^"%#{search_term}%"))
    |> order_by(desc: :updated_at)
    |> Repo.all
  end

  def find_donors_by_ids(ids) do
    Donor
    |> where([d], d.id in ^ids)
    |> Repo.all
  end

  def filter_donors(duration) do
    today = Timex.now("America/Vancouver")

    query = cond do
      duration == "today" ->
        from p in Donor, where: p.inserted_at >= ^Timex.beginning_of_day(today)
      duration == "this week" ->
        from p in Donor, where: p.inserted_at >= ^Timex.beginning_of_week(today)
      duration == "this month" ->
        from p in Donor, where: p.inserted_at >= ^Timex.beginning_of_month(today)
      duration == "this year" ->
        from p in Donor, where: p.inserted_at >= ^Timex.beginning_of_year(today)
    end

    query
    |> Repo.all
  end

  def filter_donors(duration, campaign_id) do
    today = Timex.now("America/Vancouver")

    query = cond do
      duration == "today" ->
        from d in Donor,
          join: p in assoc(d, :payments),
          where: p.campaign_id == ^campaign_id,
          where: p.inserted_at >= ^Timex.beginning_of_day(today),
          preload: [payments: p]
      duration == "this week" ->
        from d in Donor,
          join: p in assoc(d, :payments),
          where: p.campaign_id == ^campaign_id,
          where: p.inserted_at >= ^Timex.beginning_of_week(today),
          preload: [payments: p]
      duration == "this month" ->
        from d in Donor,
          join: p in assoc(d, :payments),
          where: p.campaign_id == ^campaign_id,
          where: p.inserted_at >= ^Timex.beginning_of_month(today),
          preload: [payments: p]
      duration == "this year" ->
        from d in Donor,
          join: p in assoc(d, :payments),
          where: p.campaign_id == ^campaign_id,
          where: p.inserted_at >= ^Timex.beginning_of_year(today),
          preload: [payments: p]
    end

    query
    |> Repo.all
  end

  def get_donor!(id) do
    donor = Repo.get!(Donor, id)
    donor = Repo.preload(donor, [:vaults, :addresses, :vault_cards, :ongoing_donations, :tags])
  end

  def get_donor_by_email!(email), do: Repo.get_by!(Donor, email: email)

  def create_donor(attrs \\ %{}) do
    %Donor{}
    |> Donor.changeset(attrs)
    |> Repo.insert
  end

  def create_tag(attrs \\ %{}, donor) do
    tag = %Tag{}
    |> Tag.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:donors, [donor])
    |> Repo.insert
  end

  def update_tag(%Tag{} = tag, donor) do
    new_tag = tag
    |> Tag.changeset(%{})
    |> Ecto.Changeset.put_assoc(:donors, [donor | tag.donors])
    |> Repo.update
  end

  def get_tag_by_name!(name), do: Repo.get_by(Tag, name: name) |> Repo.preload([:donors])

  def remove_tag(attrs \\ %{}) do
    "donor_tags"
    |> where(donor_id: ^String.to_integer(attrs["donor_id"]))
    |> where(tag_id: ^String.to_integer(attrs["id"]))
    |> Repo.delete_all
  end

  def update_donor(%Donor{} = donor, attrs) do
    donor
    |> Donor.changeset(attrs)
    |> Repo.update
  end

  def update_donor_with_tags(%Donor{} = donor, attrs) do
    donor
    |> Donor.changeset_add_tags(attrs)
    |> Repo.update
  end

  def mark_account_as_verified(%Donor{} = donor) do
    donor
    |> Donor.changeset(%{verified: true})
    |> Repo.update
  end

  def get_address!(id) do
    Address
    |> Repo.get!(id)
    |> Repo.preload(:donor)
  end

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

  def delete_address(%Address{} = model), do: Repo.delete(model)

  def list_addresses_for_donor(donor_id) do
    Address
    |> where([a], a.donor_id == ^donor_id)
    |> Repo.all
  end

  def list_tags_for_donor(donor_id) do
    donor = Donor.get_donor!(donor_id)
    donor = Repo.preload(donor, :tags)
    donor.tags
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
    donor = Donor.get_donor!(donor_id)
    donor = Repo.preload(donor, :vaults)
    donor.vaults
  end

  def get_cards_for_vault(vault_id) do
    VaultCard
    |> where([card], card.vault_id == ^vault_id)
    |> Repo.all
  end

  def get_vault_card!(id), do: Repo.get!(VaultCard, id)

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

  def update_vault_card(%VaultCard{} = vault_card, attrs \\ %{}) do
    Multi.new()
    |> send_iats_vault_card_update(vault_card, attrs)
    |> locally_update_vault_card(vault_card, attrs)
    |> Repo.transaction
  end

  def delete_vault_card(%VaultCard{} = vault_card, vault_id) do
    Multi.new()
    |> send_iats_vault_card_deletion(vault_card, vault_id)
    |> locally_delete_vault_card(vault_card)
    |> Repo.transaction
  end

  defp send_iats_vault_card_update(multi, vault_card, attrs) do
    Multi.run(multi, :updated_card, fn _repo, %{} ->
      card = Exiats.update_card_in_vault(attrs["vault_ids"], vault_card.iats_id, attrs["expiry_month"], attrs["expiry_year"])
      {:ok, card}
    end)
  end

  defp send_iats_vault_card_deletion(multi, vault_card, attrs) do
    Multi.run(multi, :updated_card, fn _repo, %{} ->
      card = Exiats.remove_card_from_vault(attrs, vault_card.iats_id)
      {:ok, card}
    end)
  end

  defp locally_update_vault_card(multi, card, attrs) do
    Multi.run(multi, :added_card, fn repo, %{updated_card: updated_card} ->

      new_card = card
      |> VaultCard.changeset(attrs)
      |> repo.update

      {:ok, new_card}
    end)
  end

  defp locally_delete_vault_card(multi, card) do
    Multi.run(multi, :added_card, fn repo, %{updated_card: updated_card} ->

      new_card = card
      |> Repo.delete
      {:ok, new_card}
    end)
  end

  defp send_iats_vault_card_creation(multi, attrs) do
    Multi.run(multi, :added_card, fn _repo, %{} ->
      card = Exiats.add_card_to_vault(attrs["vault_key"], attrs["cryptogram"])
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
