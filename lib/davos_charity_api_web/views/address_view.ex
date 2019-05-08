defmodule DavosCharityApiWeb.AddressView do
  use DavosCharityApiWeb, :view
  use JaSerializer.PhoenixView

  location "/api/addresses/:id"
  attributes [:name, :address_1, :address_2, :postal_code, :city, :province, :country, :primary]

  has_one :donor,
    serializer: LibraryApiWeb.DonorView,
    identifiers: :when_included,
    links: [
      related: "/api/addresses/:id/donor"
    ]

end
