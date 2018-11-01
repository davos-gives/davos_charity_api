defmodule DavosCharityApiWeb.AddressView do
  use DavosCharityApiWeb, :view
  use JaSerializer.PhoenixView

  location "/addresses/:id"
  attributes [:name, :address_1, :address_2, :postal_code, :city, :province, :country]
end
