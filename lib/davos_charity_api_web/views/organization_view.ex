defmodule DavosCharityApiWeb.OrganizationView do
  use DavosCharityApiWeb, :view
  use JaSerializer.PhoenixView

  location "/organizations/:id"
  attributes [:name, :logo]

    has_many :campaigns,
      serializer: LibraryApiWeb.CampaignView,
      identifiers: :when_included,
      links: [
        related: "/organizations/:id/campaigns"
      ]

    has_many :donor_organization_relationships,
      serializer: LibraryApiWeb.DonorOrganizationRelationshipView,
      identifier: :when_included,
      links: [
        related: "/organizations/:id/relationships"
      ]
end
