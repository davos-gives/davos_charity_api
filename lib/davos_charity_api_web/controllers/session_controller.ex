defmodule DavosCharityApiWeb.SessionController do
  use DavosCharityApiWeb, :controller

  alias Comeonin.Bcrypt

  alias DavosCharityApi.Donor

  require IEx

  def create(conn, %{"email" => email, "password" => password}) do
    try do
      donor = Donor.get_donor_by_email!(email)
      if Bcrypt.checkpw(password, donor.password_hash) do
        conn
        |> render("token.json", donor)
      else
        conn
        |> put_status(:unauthorized)
        |> render(DavosCharityApiWeb.ErrorView, "401.json-api", %{detail: "Error logging in a user with that email and password"})
      end
    rescue
      e ->
        Bcrypt.dummy_checkpw()

        conn
        |> put_status(:unauthorized)
        |> render(DavosCharityApiWeb.ErrorView, "401.json-api", %{detail: "Error logging in a user with that email and password"})
    end
  end
end
