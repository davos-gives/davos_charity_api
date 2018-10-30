defmodule DavosCharityApiWeb.PageController do
  use DavosCharityApiWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
