defmodule DavosCharityApiWeb.OngoingDonationView do
  use DavosCharityApiWeb, :view
  use JaSerializer.PhoenixView

  location "/api/ongoing-donations/:id"
  attributes [:frequency, :status, :amount, :created_at, :reference_number]

  def attributes(model, conn) do
    model
    |> Map.put(:created_at, model.inserted_at)
    |> super(conn)
  end

  has_one :donor,
    serializer: LibraryApiWeb.DonorView,
    identifiers: :when_included,
    links: [
      related: "/api/ongoing-donations/:id/donor"
    ]

  has_one :vault_card,
    serializer: LibraryApiWeb.VaultCardView,
    identifiers: :when_included,
    links: [
      related: "/api/ongoing-donations/:id/vault-card"
    ]

    has_one :payment_method,
    serializer: DavosCharityApiWeb.PaymentMethodView,
    identifiers: :when_included,
    links: [
      related: "/api/ongoing-donations/:id/payment-method"
    ]

    has_one :campaign,
      serializer: LibraryApiWeb.CampaignView,
      identifiers: :when_included,
      links: [
        related: "/api/ongoing-donations/:id/campaign"
      ]

    has_one :donor_organization_relationship,
      serializer: LibraryApiWeb.DonorOrganiztaionRelationshipView,
      identifiers: :when_included,
      links: [
        related: "/api/ongoing-donations/:id/donor-organization-relationship"
      ]

end
