defmodule DavosCharityApi.Donor do
  use Ecto.Schema
  import Ecto.Changeset

  alias DavosCharityApi.Repo
  alias DavosCharityApi.Donor
  alias DavosCharityApi.Donor.Address
  alias DavosCharityApi.Donor.PaymentMethod
  alias DavosCharityApi.Donor.DonorOrganizationRelationship
  alias DavosCharityApi.Donation
  alias DavosCharityApi.Donation.Ongoing
  alias DavosCharityApi.Donation.Payment

  import Ecto.Query

  schema "donors" do
    field :email, :string
    field :fname, :string
    field :lname, :string

    has_many :addresses, Address
    has_many :payment_methods, PaymentMethod
    has_many :ongoing_payments, Ongoing
    has_many :payments, Payment
    has_many :donor_organization_relationships, DonorOrganizationRelationship
    timestamps()
  end

  @doc false
  def changeset(donor, attrs) do
    donor
    |> cast(attrs, [:fname, :lname, :email])
    |> validate_required([:fname, :lname, :email])
  end

  def list_donors, do: Repo.all(Donor)

  def get_donor!(id), do: Repo.get!(Donor, id)

  def create_donor(attrs \\ %{}) do
    %Donor{}
    |> Donor.changeset(attrs)
    |> Repo.insert
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

  def list_payment_methods_for_donor(donor_id) do
    PaymentMethod
    |> where([pm], pm.donor_id == ^donor_id)
    |> Repo.all
  end

  def get_payment_method!(id), do: Repo.get!(PaymentMethod, id)

  def get_donor_for_payment_method!(payment_method_id) do
    payment_method = Donor.get_payment_method!(payment_method_id)
    payment_method = Repo.preload(payment_method, :donor)
    payment_method.donor
  end

  def create_payment_method(attrs \\ %{}) do
    %PaymentMethod{}
    |> PaymentMethod.changeset(attrs)
    |> Repo.insert
  end

  def update_payment_method(%PaymentMethod{} = payment_method, attrs) do
    payment_method
    |> PaymentMethod.changeset(attrs)
    |> Repo.update
  end

  def get_donor_organization_relationship!(id), do: Repo.get!(DonorOrganizationRelationship, id)

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
end
