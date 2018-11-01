defmodule DavosCharityApiWeb.DonorView do
  use DavosCharityApiWeb, :view
  use JaSerializer.PhoenixView

  location "/donors/:id"
  attributes [:fname, :lname, :email]

  has_many :addresses,
  serializer: DavosCharityApiWeb.AddressView,
  identifiers: :when_included,
  links: [
    related: "donors/:id/reviews"
  ]

  has_many :payment_methods,
  serializer: DavosCharityApiWeb.PaymentView,
  identifiers: :when_included,
  links: [
    related: "donors/:id/payment-methods"
  ]
end
