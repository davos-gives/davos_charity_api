defmodule DavosCharityApi.Donor.DonorHistory do
  use Ecto.Schema
  import Ecto.Changeset

  alias DavosCharityApi.Donor
  alias DavosCharityApi.Donor.DonorHistory
  alias DavosCharityApi.Donation.Payment
  alias DavosCharityApi.Donation.Ongoing

  schema "donor_histories" do
    field :amount, :integer
    field :status, :string
    field :history_type, :string
    field :frequency, :string
    field :before_amount, :integer
    field :after_amount, :integer
    field :before_frequency, :string
    field :after_frequency, :string
    belongs_to :donor, Donor
    belongs_to :ongoing_donation, Ongoing
    belongs_to :payment, Payment
    timestamps()
  end

  def changeset(%DonorHistory{} = model, attrs) do
    model
    |> cast(attrs, [:amount, :status, :history_type, :frequency, :before_amount, :after_amount, :before_frequency, :after_frequency, :payment_id, :ongoing_donation_id, :donor_id])
    |> validate_required([:donor_id])
  end
end
