defmodule DavosCharityApiWeb.Admin.SignatureView do
  use DavosCharityApiWeb, :view
  use JaSerializer.PhoenixView

  location "/admin/signatures/:id"
  attributes [:url, :category]

  def attributes(model, conn) do
    model
    |> Map.put(:created_at, model.inserted_at)
    |> super(conn)
  end
end
