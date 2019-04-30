defmodule DavosCharityApiWeb.Api.CampaignView do
  use DavosCharityApiWeb, :view
  use JaSerializer.PhoenixView

  location "/api/campaigns/:id"
  attributes [:name, :status, :image, :description, :has_end_date, :go_back_url, :image_url, :font, :end_date, :end_month, :end_year, :primary_colour, :secondary_colour, :tertiary_colour, :quaternary_colour, :quinary_colour, :facebook_share, :twitter_share, :linkedin_share, :email_share, :published, :created_at, :updated_at, :template_id]
  attributes [:goal, :has_goal, :show_goal]

  def attributes(model, conn) do
    model
    |> Map.put(:created_at, model.inserted_at)
    |> super(conn)
  end

  has_one :organization,
    serializer: LibraryApiWeb.OrganizationView,
    identifiers: :when_included,
    links: [
      related: "/api/campaigns/:id/organization"
    ]

  # has_one :template,
  #   serializer: LibraryApiWeb.TemplateView,
  #   identifiers: :when_included,
  #   links: [
  #     related: "/api/admin/campaigns/:id/template"
  #   ]

  has_many :payments,
    serializer: LibraryApiWeb.Admin.PaymentView,
    identifiers: :when_included,
    links: [
      related: "/api/campaigns/:id/payments"
     ]
end
