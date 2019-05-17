defmodule DavosCharityApiWeb.Admin.ReceiptTemplateView do
  use DavosCharityApiWeb, :view
  use JaSerializer.PhoenixView

  location "/admin/receipt-templates/:id"
  attributes [:logo, :header, :description, :signature, :font, :primary_colour, :secondary_colour, :tertiary_colour, :quaternary_colour, :quinary_colour]

  def attributes(model, conn) do
    model
    |> Map.put(:created_at, model.inserted_at)
    |> super(conn)
  end
end
