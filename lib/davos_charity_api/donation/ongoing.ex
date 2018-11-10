defmodule DavosCharityApi.Donation.Ongoing do
  use Ecto.Schema
  import Ecto.Changeset

  alias DavosCharityApi.Donor
  alias DavosCharityApi.Donor.PaymentMethod
  alias DavosCharityApi.Donation.Ongoing

  schema "donation_ongoing" do
    field :frequency, :string
    field :status, :string
    field :amount, :integer

    belongs_to :donor, Donor
    belongs_to :payment_method, PaymentMethod

    timestamps()
  end

  def changeset(%Ongoing{} = model, attrs) do
    model
    |> cast(attrs, [:frequency, :status, :amount, :donor_id, :payment_method_id])
    |> validate_required([:frequency, :status, :amount, :donor_id, :payment_method_id])
  end
end
