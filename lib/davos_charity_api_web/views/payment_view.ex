defmodule DavosCharityApiWeb.PaymentView do
  use DavosCharityApiWeb, :view
  use JaSerializer.PhoenixView

  location "/payments/:id"
  attributes [:amount]

  has_one :donor,
    serializer: LibraryApiWeb.DonorView,
    identifiers: :when_included,
    links: [
      related: "/api/payments/:id/donor"
    ]

  has_one :campaign,
    serializer: LibraryApiWeb.CampaignView,
    identifiers: :when_included,
    links: [
      related: "/api/payments/:id/campaign"
    ]

    has_one :donor_organization_relationship,
      serializer: LibraryApiWeb.DonorOrganiztaionRelationshipView,
      identifiers: :when_included,
      links: [
        related: "/api/payments/:id/donor-organization-relationship"
      ]
end
