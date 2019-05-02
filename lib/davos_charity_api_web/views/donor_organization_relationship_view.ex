defmodule DavosCharityApiWeb.DonorOrganizationRelationshipView do
  use DavosCharityApiWeb, :view
  use JaSerializer.PhoenixView

  require IEx

  location "/api/donor-organization-relationships/:id"
  attributes [:yearly_donations, :lifetime_donations, :created_at]

  def attributes(model, conn) do
    model
    |> Map.put(:yearly_donations, Enum.reduce(model.payments, 0, fn x, acc -> x.amount + acc end))
    |> Map.put(:lifetime_donations, Enum.reduce(model.payments, 0, fn x, acc -> x.amount + acc end))
    |> Map.put(:created_at, model.inserted_at)
    |> super(conn)
  end

  has_one :organization,
    serializer: LibraryApiWeb.OrganizationView,
    identifiers: :when_included,
    links: [
      related: "/api/donor-organization-relationships/:id/organization"
    ]

  has_one :donor,
    serializer: LibraryApiWeb.DonorView,
    identifiers: :when_included,
    links: [
      related: "/api/donor-organization-relationships/:id/donor"
    ]

  has_many :ongoing_donations,
    serializer: DavosCharityApiWeb.OngoingView,
    identifiers: :when_included,
    links: [
      related: "/api/donor-organization-relationships/:id/ongoing-donations"
    ]

  has_many :payments,
    serializer: DavosCharityApiWeb.PaymentView,
    identifiers: :when_included,
    links: [
      related: "/api/donor-organization-relationships/:id/payments"
    ]


end
