defmodule DavosCharityApiWeb.PaymentController do
  use DavosCharityApiWeb, :controller

  alias DavosCharityApi.Donor
  alias DavosCharityApi.Donation

  def payments_for_donor(conn, %{"donor_id" => donor_id}) do
    payments = Donation.list_payments_for_donor(donor_id)
    render(conn, "index.json-api", data: payments)
  end

  def payments_for_ongoing_relationship(conn, %{"relationship_id" => relationship_id}) do
    payments = Donation.list_payments_for_relationship(relationship_id)
    render(conn, "index.json-api", data: payments)
  end

end
