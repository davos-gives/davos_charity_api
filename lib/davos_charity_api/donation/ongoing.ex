defmodule DavosCharityApi.Donation.Ongoing do
  use Ecto.Schema
  import Ecto.Changeset

  alias DavosCharityApi.Donor
  alias DavosCharityApi.Donor.PaymentMethod
  alias DavosCharityApi.Donation.Ongoing
  alias DavosCharityApi.Fundraising.Campaign
  alias DavosCharityApi.Donor.DonorOrganizationRelationship
  alias DavosCharityApi.Donor.VaultCard

  schema "donation_ongoing" do
    field :frequency, :string
    field :status, :string
    field :amount, :integer
    field :reference_number, :string
    field :source, :string

    belongs_to :donor, Donor
    belongs_to :campaign, Campaign
    belongs_to :payment_method, PaymentMethod
    belongs_to :vault_card, VaultCard
    belongs_to :donor_organization_relationship, DonorOrganizationRelationship

    timestamps()
  end

  def changeset(%Ongoing{} = model, attrs) do
    model
    |> cast(attrs, [:frequency, :status, :amount, :donor_id, :vault_card_id, :campaign_id, :donor_organization_relationship_id, :reference_number])
    |> validate_required([:status, :reference_number])
  end
end
