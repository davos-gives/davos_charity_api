defmodule DavosCharityApiWeb.DonorOrganizationRelationshipView do
  use DavosCharityApiWeb, :view
  use JaSerializer.PhoenixView

  location "/relationships/:id"
  attributes [:yearly_donations, :lifetime_donations]


  def attributes(model, conn) do
    model
    |> Map.put(:yearly_donations, 58115)
    |> Map.put(:lifetime_donations, 100035)
    |> super(conn)
  end

  has_one :organization,
    serializer: LibraryApiWeb.OrganizationView,
    identifiers: :when_included,
    links: [
      related: "/relationships/:id/organization"
    ]

  has_one :donor,
    serializer: LibraryApiWeb.DonorView,
    identifiers: :when_included,
    links: [
      related: "/relationships/:id/donor"
    ]

end
