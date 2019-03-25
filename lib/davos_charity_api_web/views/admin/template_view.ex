defmodule DavosCharityApiWeb.Admin.TemplateView do
  use DavosCharityApiWeb, :view
  use JaSerializer.PhoenixView

  location "/api/admin/templates/:id"
  attributes [:name, :status, :image, :description, :has_end_date, :go_back_url, :image_url, :font, :end_date, :end_month, :end_year, :primary_colour, :secondary_colour, :tertiary_colour, :quaternary_colour, :quinary_colour, :facebook_share, :twitter_share, :linkedin_share, :email_share, :published, :created_at, :updated_at]

  def attributes(model, conn) do
    model
    |> Map.put(:created_at, model.inserted_at)
    |> super(conn)
  end

end
