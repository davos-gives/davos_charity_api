defmodule DavosCharityApiWeb.DonorController do
  use DavosCharityApiWeb, :controller

  alias DavosCharityApi.Donor

  def show(conn, %{"id" => id}) do
    donor = Donor.get_donor!(id)
    render(conn, "show.json-api", data: donor)
  end

  def index(conn, _params) do
    donors = Donor.list_donors()
    render(conn, "index.json-api", data: donors)
  end

  def donor_for_ongoing_donation(conn, %{"ongoing_donation_id" => ongoing_donation_id}) do
    donor = Donor.get_donor_for_ongoing_donation!(ongoing_donation_id)
    render(conn, "show.json-api", data: donor)
  end
end
