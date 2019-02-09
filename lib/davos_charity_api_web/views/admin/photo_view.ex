defmodule DavosCharityApiWeb.Admin.PhotoView do
  use DavosCharityApiWeb, :view
  use JaSerializer.PhoenixView

  location "/admin/photos/:id"
  attributes [:url, :category]

  def attributes(model, conn) do
    model
    |> Map.put(:created_at, model.inserted_at)
    |> super(conn)
  end
end
