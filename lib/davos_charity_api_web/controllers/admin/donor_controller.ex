defmodule DavosCharityApiWeb.Admin.DonorController do
  use DavosCharityApiWeb, :controller

  alias DavosCharityApi.Donor
  alias DavosCharityApi.Donation

  alias DavosCharityApi.Repo


  plug :authenticate_donor when action in [:show_current]

  def show_current(conn, %{current_donor: donor}) do
    conn
    |> render("show.json-api", data: donor)
  end

  def show(conn, %{"id" => id}) do
    donor = Donor.get_donor!(id)
    render(conn, "show.json-api", data: donor)
  end

  def index(conn, %{"filter" => %{"query" => search_term}}) do
    donors = Donor.search_donors(search_term)
    render(conn, "index.json-api", data: donors)
  end

  def index(conn, %{"filter" => %{"range" => duration, "campaign" => campaign_id}}) do

    donors = Donor.filter_donors(duration, campaign_id)
    render(conn, "index.json-api", data: donors)
  end

  def index(conn, %{"filter" => %{"range" => duration}}) do

    donors = Donor.filter_donors(duration)
    render(conn, "index.json-api", data: donors)
  end

  def index(conn, _params) do
    donors = Donor.list_donors()
    render(conn, "index.json-api", data: donors)
  end

  def donor_for_ongoing_donation(conn, %{"ongoing_donation_id" => ongoing_donation_id}) do
    donor = Donation.get_donor_for_ongoing_donation!(ongoing_donation_id)
    render(conn, "show.json-api", data: donor)
  end

  def donor_for_address(conn, %{"address_id" => address_id}) do
    donor = Donor.get_donor_for_address!(address_id)
    render(conn, "show.json-api", data: donor)
  end

  def donor_for_payment_method(conn, %{"payment_method_id" => payment_method_id}) do
    donor = Donor.get_donor_for_payment_method!(payment_method_id)
    render(conn, "show.json-api", data: donor)
  end

  def get_donor_for_relationship(conn, %{"relationship_id" => relationship_id}) do
    relationship = Donor.get_donor_for_relationship!(relationship_id)
    render(conn, "show.json-api", data: relationship)
  end

  def get_donor_for_payment(conn, %{"payment_id" => payment_id}) do
    donor = Donation.get_donor_for_payment!(payment_id)
    render(conn, "show.json-api", data: donor)
  end
end
