defmodule DavosCharityApiWeb.TemplateView do
  use DavosCharityApiWeb, :view

  import IEx

  def cents_to_dollars(cents) do
    cents / 100 |> Number.Currency.number_to_currency()
  end
end
