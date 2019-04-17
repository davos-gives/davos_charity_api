defmodule DavosCharityApiWeb.PaymentView do
  use DavosCharityApiWeb, :view
  use JaSerializer.PhoenixView

  require IEx

  location "/payments/:id"
  attributes [:amount, :created_at, :cryptogram]

  def attributes(model, conn) do
    model
    |> Map.put(:created_at, model.inserted_at)
    |> super(conn)
  end

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
