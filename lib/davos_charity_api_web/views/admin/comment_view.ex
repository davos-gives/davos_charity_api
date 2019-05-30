defmodule DavosCharityApiWeb.Admin.CommentView do
  use DavosCharityApiWeb, :view
  use JaSerializer.PhoenixView

  location "/api/admin/comments/:id"
  attributes [:body]

  has_one :donor,
    serializer: LibraryApiWeb.Admin.DonorView,
    identifiers: :when_included,
    links: [
      related: "/api/admin/comments/:id/donor"
    ]

   has_one :user,
     serializer: LibraryApiWeb.Admin.UserView,
     identifiers: :when_included,
     links: [
       related: "/api/admin/comments/:id/user"
     ]

end
