defmodule DavosCharityApiWeb.Admin.OngoingDonationView do
  use DavosCharityApiWeb, :view
  use JaSerializer.PhoenixView

  location "/api/admin/ongoing-donations/:id"
  attributes [:frequency, :status, :amount, :created_at]

  def attributes(model, conn) do
    model
    |> Map.put(:created_at, model.inserted_at)
    |> super(conn)
  end

  has_one :donor,
    serializer: LibraryApiWeb.Admin.DonorView,
    identifiers: :when_included,
    links: [
      related: "/api/admin/ongoing-donations/:id/donor"
    ]

    has_one :payment_method,
    serializer: DavosCharityApiWeb.Admin.PaymentMethodView,
    identifiers: :when_included,
    links: [
      related: "/api/admin/ongoing-donations/:id/payment-method"
    ]

    has_one :campaign,
      serializer: LibraryApiWeb.Admin.CampaignView,
      identifiers: :when_included,
      links: [
        related: "/api/admin/ongoing-donations/:id/campaign"
      ]

    has_one :donor_organization_relationship,
      serializer: LibraryApiWeb.Admin.DonorOrganiztaionRelationshipView,
      identifiers: :when_included,
      links: [
        related: "/api/admin/ongoing-donations/:id/donor-organization-relationship"
      ]

end
