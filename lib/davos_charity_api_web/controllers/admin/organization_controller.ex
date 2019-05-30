defmodule DavosCharityApiWeb.Admin.OrganizationController do
  use DavosCharityApiWeb, :controller

  alias DavosCharityApi.Organization.Management

  require IEx

  def organization_for_user(conn, %{"user_id" => user_id}) do

    organization = Management.get_organization_for_user(user_id)
    render(conn, "show.json-api", data: organization)
  end
end
