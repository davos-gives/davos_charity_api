defmodule DavosCharityApiWeb.Admin.UserController do
  use DavosCharityApiWeb, :controller

  alias DavosCharityApi.Organization.Management
  alias IEx

  plug :authenticate_user when action in [:show_current]

  def show_current(conn, %{current_user: user}) do
    conn
    |> render("show.json-api", data: user)
  end

  def show(conn, %{"id" => id}) do
    donor = Management.get_user!(id)
    render(conn, "show.json-api", data: donor)
  end
end
