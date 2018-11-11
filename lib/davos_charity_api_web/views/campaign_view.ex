defmodule DavosCharityApiWeb.CampaignView do
  use DavosCharityApiWeb, :view
  use JaSerializer.PhoenixView

  location "/campaigns/:id"
  attributes [:name, :type, :status]

  has_one :organization,
    serializer: LibraryApiWeb.OrganizationView,
    identifiers: :when_included,
    links: [
      related: "/campaigns/:id/organization"
    ]
end
