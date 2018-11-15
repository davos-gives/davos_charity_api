defmodule DavosCharityApiWeb.OngoingDonationView do
  use DavosCharityApiWeb, :view
  use JaSerializer.PhoenixView

  location "/api/ongoing-donations/:id"
  attributes [:frequency, :status, :amount]

  has_one :donor,
    serializer: LibraryApiWeb.DonorView,
    identifiers: :when_included,
    links: [
      related: "/ongoing-donations/:id/donor"
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

end
