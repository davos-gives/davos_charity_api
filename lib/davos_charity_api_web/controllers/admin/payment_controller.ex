defmodule DavosCharityApiWeb.Admin.PaymentController do
  use DavosCharityApiWeb, :controller

  alias DavosCharityApi.Donation

  def show(conn, %{"id" => id}) do
    donor = Donation.get_payment!(id)
    render(conn, "show.json-api", data: donor)
  end

  def index(conn, %{"filter" => %{"range" => duration, "campaign" => campaign_id}}) do
    payments = Donation.search_payments(duration, campaign_id)
    render(conn, "index.json-api", data: payments)
  end

  def index(conn, %{"filter" => %{"range" => duration}}) do

    payments = Donation.search_payments(duration)
    render(conn, "index.json-api", data: payments)
  end

  def index(conn, _params) do

    payments = Donation.list_payments()
    render(conn, "index.json-api", data: payments)
  end

  def get_payments_for_donor(conn, %{"donor_id" => donor_id}) do
    payments = Donation.list_payments_for_donor(donor_id)
    render(conn, "index.json-api", data: payments)
  end

  def get_payments_for_campaign(conn, %{"campaign_id" => campaign_id}) do
    payments = Donation.list_payments_for_campaign(campaign_id)
    render(conn, "index.json-api", data: payments)
  end
end
