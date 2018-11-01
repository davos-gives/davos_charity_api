defmodule DavosCharityApiWeb.PaymentMethodController do
  use DavosCharityApiWeb, :controller

  alias DavosCharityApi.Donor

  def payment_methods_for_donor(conn, %{"donor_id" => donor_id}) do
    payments = Donor.list_payment_methods_for_donor(donor_id)
    render(conn, "index.json-api", data: payments)
  end
end
