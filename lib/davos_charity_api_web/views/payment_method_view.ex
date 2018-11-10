defmodule DavosCharityApiWeb.PaymentMethodView do
  use DavosCharityApiWeb, :view
  use JaSerializer.PhoenixView

  location "/payment-methods/:id"
  attributes [:name, :type, :number, :expiry, :cvv]

  has_one :donor,
    serializer: LibraryApiWeb.DonorView,
    identifiers: :when_included,
    links: [
      related: "/payment-methods/:id/donor"
    ]
end
