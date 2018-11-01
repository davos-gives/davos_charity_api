defmodule DavosCharityApiWeb.PaymentMethodView do
  use DavosCharityApiWeb, :view
  use JaSerializer.PhoenixView

  location "/payment-methods/:id"
  attributes [:name, :type, :number, :expiry, :cvv]
end
