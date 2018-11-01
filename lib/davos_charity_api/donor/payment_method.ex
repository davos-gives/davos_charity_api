defmodule DavosCharityApi.Donor.PaymentMethod do
  use Ecto.Schema
  import Ecto.Changeset

  alias DavosCharityApi.Donor
  alias DavosCharityApi.Donor.PaymentMethod

  schema "donor_payment_methods" do
    field :name, :string
    field :type, :string
    field :number, :string
    field :expiry, :string
    field :cvv, :integer

    belongs_to :donor, Donor
    timestamps()
  end

  def changeset(%PaymentMethod{} = model, attrs) do
    model
    |> cast(attrs, [:name, :type, :number, :expiry, :cvv, :donor_id])
    |> validate_required([:name, :type, :number, :expiry, :cvv, :donor_id])
  end
end
