defmodule DavosCharityApiWeb.Admin.DonorHistoryController do
  use DavosCharityApiWeb, :controller

  alias DavosCharityApi.Donor

  def index(conn, _params) do
    history = Donor.list_donor_history()
    render(conn, "index.json-api", data: history)
  end

  def history_for_donor(conn, %{"donor_id" => donor_id}) do
    history = Donor.list_history_for_donor(donor_id)
    render(conn, "index.json-api", data: history)
  end
end
