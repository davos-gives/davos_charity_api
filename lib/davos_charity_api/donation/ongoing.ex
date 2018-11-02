defmodule DavosCharityApi.Donation.Ongoing do
  use Ecto.Schema
  import Ecto.Changeset

  alias DavosCharityApi.Donor
  alias DavosCharityApi.Donation.Ongoing

  schema "donation_ongoing" do
    field :frequency, :string
    field :status, :string
    field :amount, :integer
    field :start_date, :utc_datetime

    belongs_to :donor, Donor

    timestamps()
  end

  def changeset(%Ongoing{} = model, attrs) do
    model
    |> cast(attrs, [:frequency, :status, :amount, :donor_id, :start_date])
    |> validate_required([:frequency, :status, :amount, :donor_id])
  end
end
