defmodule DavosCharityApiWeb.Admin.UserView do
  use DavosCharityApiWeb, :view
  use JaSerializer.PhoenixView

  location "/admin/users/:id"
  attributes [:fname, :lname]

  has_one :organization,
    serializer: LibraryApiWeb.Admin.OrganizationView,
    identifiers: :when_included,
    links: [
      related: "/api/admin/users/:id/organization"
     ]
end
