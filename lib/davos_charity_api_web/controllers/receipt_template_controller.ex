defmodule DavosCharityApiWeb.ReceiptTemplateController do
  use DavosCharityApiWeb, :controller

  alias DavosCharityApi.Fundraising

  def show(conn, %{"receipt_template_id" => receipt_template_id}) do
    template = Fundraising.get_receipt_template!(receipt_template_id)

    render(conn, "show.html", template: template)
  end

end
