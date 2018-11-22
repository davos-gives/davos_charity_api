defmodule DavosCharityApiWeb.Admin.DonorView do
  use DavosCharityApiWeb, :view
  use JaSerializer.PhoenixView

  location "/api/admin/donors/:id"
  attributes [:fname, :lname, :email]

  has_many :addresses,
  serializer: DavosCharityApiWeb.Admin.AddressView,
  identifiers: :when_included,
  links: [
    related: "/api/admin/donors/:id/addresses"
  ]

  has_many :payment_methods,
  serializer: DavosCharityApiWeb.Admin.PaymentMethodView,
  identifiers: :when_included,
  links: [
    related: "/api/admin/donors/:id/payment-methods"
  ]

  has_many :ongoing_donations,
  serializer: DavosCharityApiWeb.Admin.OngoingView,
  identifiers: :when_included,
  links: [
    related: "/api/admin/donors/:id/ongoing-donations"
  ]

  has_many :payments,
  serializer: DavosCharityApiWeb.Admin.PaymentView,
  identifiers: :when_included,
  links: [
    related: "/api/admin/donors/:id/payments"
  ]

  has_many :donor_history,
  serializer: DavosCharityApiWeb.Admin.DonorHistoryView,
  identifiers: :when_included,
  links: [
    related: "/api/admin/donors/:id/donor-history"
  ]
end
