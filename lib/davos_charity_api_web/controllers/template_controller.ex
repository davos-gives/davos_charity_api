defmodule DavosCharityApiWeb.TemplateController do
  use DavosCharityApiWeb, :controller

  alias DavosCharityApi.Fundraising

  def show(conn, %{"template_id" => template_id}) do
    template = Fundraising.get_template!(template_id)

    render(conn, "show.html", template: template)
  end

end
