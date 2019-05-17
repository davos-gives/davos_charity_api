defmodule DavosCharityApiWeb.Admin.ReceiptView do
  use DavosCharityApiWeb, :view
  use JaSerializer.PhoenixView

  location "/admin/receipts/:id"
  attributes [:url, :fname, :lname, :payment_amount, :inserted_at, :receipt_number]

  def attributes(model, conn) do
    model
    |> Map.put(:created_at, model.inserted_at)
    |> super(conn)
  end

  has_one :payments,
    serializer: LibraryApiWeb.PaymentView,
    identifiers: :when_included,
    links: [
      related: "/api/receipts/:id/payment"
     ]
end
