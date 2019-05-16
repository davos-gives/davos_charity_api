defmodule DavosCharityApiWeb.ReceiptView do
  use DavosCharityApiWeb, :view

  def cents_to_dollars(cents) do
    cents / 100 |> Number.Currency.number_to_currency()
  end

end
