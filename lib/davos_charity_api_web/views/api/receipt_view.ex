defmodule DavosCharityApiWeb.Api.ReceiptView do
  use DavosCharityApiWeb, :view
  use JaSerializer.PhoenixView

  location "/api/receipts/:id"
  attributes [:url]

  has_one :payments,
    serializer: LibraryApiWeb.PaymentView,
    identifiers: :when_included,
    links: [
      related: "/api/receipts/:id/payment"
     ]
end
