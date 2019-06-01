defmodule DavosCharityApiWeb.Admin.ReceiptController do
  use DavosCharityApiWeb, :controller

  alias DavosCharityApi.Fundraising
  alias DavosCharityApi.Donation
  alias DavosCharityApi.Receipt

  def index(conn, %{"filter" => %{"query" => search_term}}) do
    receipts = Receipt.search_receipts(search_term)
    render(conn, "index.json-api", data: receipts)
  end

  def index(conn, _params) do
    receipts = Receipt.list_receipts
    render(conn, "index.json-api", data: receipts)
  end

  def show(conn, %{"id" => id}) do
    campaign = Fundraising.get_campaign!(id)
    render(conn, "show.json-api", data: campaign)
  end

end
