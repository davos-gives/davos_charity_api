defmodule DavosCharityApiWeb.OngoingDonationController do
  use DavosCharityApiWeb, :controller

  alias DavosCharityApi.Donor

  def show(conn, %{"id" => id}) do
    donation = Donor.get_ongoing_donation!(id)
    render(conn, "show.json-api", data: donation)
  end

  def ongoing_donations_for_donor(conn, %{"donor_id" => donor_id}) do
    ongoing_payments = Donor.list_ongoing_donations_for_donor(donor_id)
    render(conn, "index.json-api", data: ongoing_payments)
  end
end
