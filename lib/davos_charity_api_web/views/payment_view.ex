defmodule DavosCharityApiWeb.PaymentView do
  use DavosCharityApiWeb, :view
  use JaSerializer.PhoenixView

  location "/payments/:id"
  attributes [:amount]

  has_one :donor,
    serializer: LibraryApiWeb.DonorView,
    identifiers: :when_included,
    links: [
      related: "/payments/:id/donor"
    ]

  has_one :campaign,
    serializer: LibraryApiWeb.CampaignView,
    identifiers: :when_included,
    links: [
      related: "/payments/:id/campaign"
    ]
end
