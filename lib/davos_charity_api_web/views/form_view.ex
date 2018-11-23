defmodule DavosCharityApiWeb.FormView do
  use DavosCharityApiWeb, :view

  import IEx

  def cents_to_dollars(cents) do
    cents / 100 |> Number.Currency.number_to_currency()
  end

  def summarize_payments(payments) do
    Enum.reduce(payments, 0, fn x, acc -> x.amount + acc end)
  end

  def unique_donors_from_payments(payments) do
    payments
    |> Enum.map(fn (x) -> x.donor_id end)
    |> Enum.uniq
    |> Enum.count
  end
end
