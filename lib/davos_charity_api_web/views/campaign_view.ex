defmodule DavosCharityApiWeb.CampaignView do
  use DavosCharityApiWeb, :view
  use JaSerializer.PhoenixView

  location "/campaigns/:id"
  attributes [:name, :status, :image]

  has_one :organization,
    serializer: LibraryApiWeb.OrganizationView,
    identifiers: :when_included,
    links: [
      related: "/api/campaigns/:id/organization"
    ]
end
