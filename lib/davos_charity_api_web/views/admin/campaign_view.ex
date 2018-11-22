defmodule DavosCharityApiWeb.Admin.CampaignView do
  use DavosCharityApiWeb, :view
  use JaSerializer.PhoenixView

  location "/admin/campaigns/:id"
  attributes [:name, :status, :image, :created_at]

  def attributes(model, conn) do
    model
    |> Map.put(:created_at, model.inserted_at)
    |> super(conn)
  end

  has_one :organization,
    serializer: LibraryApiWeb.OrganizationView,
    identifiers: :when_included,
    links: [
      related: "/api/admin/campaigns/:id/organization"
    ]

  has_many :payments,
    serializer: LibraryApiWeb.Admin.PaymentView,
    identifiers: :when_included,
    links: [
      related: "/api/admin/campaigns/:id/payments"
     ]
end
