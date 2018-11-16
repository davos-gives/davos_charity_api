defmodule DavosCharityApiWeb.DonorOrganizationRelationshipController do
  use DavosCharityApiWeb, :controller

  alias DavosCharityApi.Donor
  alias DavosCharityApi.Donation

  def show(conn, %{"id" => id}) do
    relationship = Donor.get_donor_organization_relationship!(id)
    render(conn, "show.json-api", data: relationship)
  end

  def relationship_for_ongoing_donation(conn, %{"ongoing_donation_id" => ongoing_donation_id}) do
    relationship = Donation.get_relationship_for_ongoing_donation(ongoing_donation_id)
    render(conn, "show.json-api", data: relationship)
  end

  def relationship_for_payment(conn, %{"payment_id" => payment_id}) do
    relationship = Donation.get_relationship_for_payment(payment_id)
    render(conn, "show.json-api", data: relationship)
  end
end
