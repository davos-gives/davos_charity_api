defmodule DavosCharityApiWeb.OngoingDonationView do
  use DavosCharityApiWeb, :view
  use JaSerializer.PhoenixView

  location "/ongoing-donations/:id"
  attributes [:frequency, :status, :amount]

  has_one :donor,
    serializer: LibraryApiWeb.DonorView,
    identifiers: :when_included,
    links: [
      related: "/ongoing-donations/:id/donor"
    ]
end
