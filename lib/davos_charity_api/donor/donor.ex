defmodule DavosCharityApi.Donor do
  use Ecto.Schema
  import Ecto.Changeset

  alias DavosCharityApi.Repo
  alias DavosCharityApi.Donor
  alias DavosCharityApi.Donor.Address
  alias DavosCharityApi.Donor.PaymentMethod

  import Ecto.Query
  
  schema "donors" do
    field :email, :string
    field :fname, :string
    field :lname, :string

    has_many :addresses, Address
    has_many :payment_methods, PaymentMethod
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

  def create_address(attrs \\ %{}) do
    %Address{}
    |> Address.changeset(attrs)
    |> Repo.insert
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
end
