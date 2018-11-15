defmodule DavosCharityApiWeb.DonorOrganizationRelationshipView do
  use DavosCharityApiWeb, :view
  use JaSerializer.PhoenixView

  require IEx


  location "/relationships/:id"
  attributes [:yearly_donations, :lifetime_donations]

  def attributes(model, conn) do
    model
    |> Map.put(:yearly_donations, Enum.reduce(model.donor.payments, 0, fn x, acc -> x.amount + acc end))
    |> Map.put(:lifetime_donations, Enum.reduce(model.donor.payments, 0, fn x, acc -> x.amount + acc end))
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
