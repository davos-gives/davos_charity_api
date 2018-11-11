defmodule DavosCharityApiWeb.DonorOrganizationRelationshipController do
  use DavosCharityApiWeb, :controller

  alias DavosCharityApi.Donor

  def show(conn, %{"id" => id}) do
    relationship = Donor.get_donor_organization_relationship!(id)
    render(conn, "show.json-api", data: relationship)
  end
end
