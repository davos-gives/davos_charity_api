defmodule DavosCharityApiWeb.Admin.TemplateController do
  use DavosCharityApiWeb, :controller

  alias DavosCharityApi.Fundraising

  def template_for_campaign(conn, %{"campaign_id" => campaign_id}) do
    template = Fundraising.get_template_for_campaign(campaign_id)
    render(conn, "show.json-api", data: template)
  end
end
