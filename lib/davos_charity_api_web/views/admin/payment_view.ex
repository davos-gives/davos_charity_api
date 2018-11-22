defmodule DavosCharityApiWeb.Admin.PaymentView do
  use DavosCharityApiWeb, :view
  use JaSerializer.PhoenixView

  require IEx

  location "/admin/payments/:id"
  attributes [:amount, :created_at, :frequency]

  def attributes(model, conn) do
    model
    |> Map.put(:created_at, model.inserted_at)
    |> super(conn)
  end

  has_one :donor,
    serializer: LibraryApiWeb.Admin.DonorView,
    identifiers: :when_included,
    links: [
      related: "/api/admin/payments/:id/donor"
    ]

  has_one :campaign,
    serializer: LibraryApiWeb.Admin.CampaignView,
    identifiers: :when_included,
    links: [
      related: "/api/admin/payments/:id/campaign"
    ]

end
