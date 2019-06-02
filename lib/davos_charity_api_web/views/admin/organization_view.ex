defmodule DavosCharityApiWeb.Admin.OrganizationView do
  use DavosCharityApiWeb, :view
  use JaSerializer.PhoenixView

  location "admin/organizations/:id"
  attributes [:name, :logo]

end
