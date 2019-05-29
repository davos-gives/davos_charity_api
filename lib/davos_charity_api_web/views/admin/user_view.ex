defmodule DavosCharityApiWeb.Admin.UserView do
  use DavosCharityApiWeb, :view
  use JaSerializer.PhoenixView

  location "/admin/users/:id"
  attributes [:fname, :lname]
end
