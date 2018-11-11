defmodule DavosCharityApiWeb.OrganizationController do
  use DavosCharityApiWeb, :controller

  alias DavosCharityApi.Fundraising
  alias DavosCharityApi.Fundraising.Campaign
  alias DavosCharityApi.Organization

  def show(conn, %{"id" => id}) do
    organization = Organization.get_organization!(id)
    render(conn, "show.json-api", data: organization)
  end

  def get_organization_for_campaign(conn, %{"campaign_id" => campaign_id}) do
    organization = Fundraising.get_organization_for_campaign(campaign_id)
    render(conn, "show.json-api", data: organization)
  end

  def get_organization_for_relationship(conn, %{"relationship_id" => relationship_id}) do
    organization = Organization.get_organization_for_relationship!(relationship_id)
    render(conn, "show.json-api", data: organization)
  end
end
