defmodule DavosCharityApiWeb.Api.ReceiptController do
  use DavosCharityApiWeb, :controller

  alias DavosCharityApi.Fundraising
  alias DavosCharityApi.Fundraising.Campaign
  alias DavosCharityApi.Donation
  alias DavosCharityApi.Receipt

  alias IEx

  def get_receipt_for_payment(conn, %{"payment_id" => payment_id}) do
    receipt = List.first(Receipt.get_receipt_for_payment!(payment_id))

    render(conn, "show.json-api", data: receipt)
  end
end
