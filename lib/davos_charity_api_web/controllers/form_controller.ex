defmodule DavosCharityApiWeb.FormController do
  use DavosCharityApiWeb, :controller

  alias DavosCharityApi.Fundraising

  def show(conn, %{"form_id" => form_id}) do    
    form = Fundraising.get_form!(form_id)

    render(conn, "show.html", form: form)
  end

end
