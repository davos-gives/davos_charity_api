defmodule DavosCharityApiWeb.Admin.DonorHistoryView do
  use DavosCharityApiWeb, :view
  use JaSerializer.PhoenixView

  location "/api/admin/donor-history/:id"
  attributes [:amount, :created_at, :status, :history_type, :frequency, :before_amount, :after_amount, :before_frequency, :after_frequency]

  def attributes(model, conn) do
    model
    |> Map.put(:created_at, model.inserted_at)
    |> super(conn)
  end

  has_one :ongoing_donation,
  serializer: DavosCharityApiWeb.Admin.OngoingView,
  identifiers: :when_included,
  links: [
    related: "/api/admin/donor-histoy/:id/ongoing-donation"
  ]

  has_one :payment,
  serializer: DavosCharityApiWeb.Admin.PaymentView,
  identifiers: :when_included,
  links: [
    related: "/api/admin/donors-history/:id/payment"
  ]

  has_one :donor,
  serializer: DavosCharityApiWeb.Admin.DonorView,
  identifiers: :when_included,
  links: [
    related: "/api/admin/donors-history/:id/donor"
  ]
end
