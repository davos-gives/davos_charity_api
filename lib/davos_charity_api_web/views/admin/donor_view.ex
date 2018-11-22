defmodule DavosCharityApiWeb.Admin.DonorView do
  use DavosCharityApiWeb, :view
  use JaSerializer.PhoenixView

  location "/admin/donors/:id"
  attributes [:fname, :lname, :email]

  has_many :addresses,
  serializer: DavosCharityApiWeb.AddressView,
  identifiers: :when_included,
  links: [
    related: "/api/admin/donors/:id/addresses"
  ]

  has_many :payment_methods,
  serializer: DavosCharityApiWeb.PaymentMethodView,
  identifiers: :when_included,
  links: [
    related: "/api/admin/donors/:id/payment-methods"
  ]

  has_many :ongoing_donations,
  serializer: DavosCharityApiWeb.OngoingView,
  identifiers: :when_included,
  links: [
    related: "/api/admin/donors/:id/ongoing-donations"
  ]

  has_many :payments,
  serializer: DavosCharityApiWeb.PaymentView,
  identifiers: :when_included,
  links: [
    related: "/api/admin/donors/:id/payments"
  ]
end
