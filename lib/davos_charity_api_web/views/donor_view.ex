defmodule DavosCharityApiWeb.DonorView do
  use DavosCharityApiWeb, :view
  use JaSerializer.PhoenixView

  location "/api/donors/:id"
  attributes [:fname, :lname, :email]

  has_many :addresses,
  serializer: DavosCharityApiWeb.AddressView,
  identifiers: :when_included,
  links: [
    related: "/api/donors/:id/addresses"
  ]

  has_many :ongoing_donations,
  serializer: DavosCharityApiWeb.OngoingDonationView,
  identifiers: :when_included,
  links: [
    related: "/api/donors/:id/ongoing-donations"
  ]

  has_many :payments,
  serializer: DavosCharityApiWeb.PaymentView,
  identifiers: :when_included,
  links: [
    related: "/api/donors/:id/payments"
  ]

  has_many :vaults,
  serializer: DavosCharityApiWeb.VaultView,
  identifiers: :when_included,
  links: [
    related: "/api/donors/:id/vaults"
  ]

  has_many :vault_cards,
  serializer: DavosCharityApiWeb.VaultCardView,
  identifiers: :when_included,
  links: [
    related: "/api/donors/:id/vault-cards"
  ]
end
