defmodule DavosCharityApiWeb.Admin.TagView do
  use DavosCharityApiWeb, :view
  use JaSerializer.PhoenixView

  location "/api/admin/tags/:id"
  attributes [:name]

end
