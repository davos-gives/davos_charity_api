defmodule DavosCharityApiWeb.Admin.SessionController do
  use DavosCharityApiWeb, :controller

  alias Comeonin.Bcrypt
  alias DavosCharityApi.Organization.User
  alias DavosCharityApi.Organization.Management

  def create(conn, %{"email" => email, "password" => password}) do
    try do
      user = Management.get_user_by_email!(email)

        if Bcrypt.checkpw(password, user.password_hash) do
          conn
          |> render("token.json", user)
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

  def create(conn, %{"data" => data = %{"type" => "session", "attributes" => _params}}) do

    data = data
    |> JaSerializer.Params.to_attributes()
    try do
      user = Management.get_user_by_email!(data["email"])
      if Bcrypt.checkpw(data["password"], user.password_hash) do
        conn
        |> render("json-token.json", user)
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
