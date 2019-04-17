defmodule DavosCharityApiWeb.Admin.LogoController do
  use DavosCharityApiWeb, :controller

  alias DavosCharityApi.Fundraising
  alias DavosCharityApi.Fundraising.Logo


  def show(conn, %{"id" => id}) do
    logo = Fundraising.get_logo!(id)
    render(conn, "show.json-api", data: logo)
  end

  def index(conn, _params) do
    logos = Fundraising.list_logos()
    render(conn, "index.json-api", data: logos)
  end

  def create(conn, %{"data" => data = %{"type" => "logos", "attributes" => _params}}) do
    data = data
    |> JaSerializer.Params.to_attributes

    case Fundraising.create_logo(data) do
      {:ok, %Logo{} = logo} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", Routes.logo_path(conn, :show, logo))
        |> render("show.json-api", data: logo)
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:bad_request)
        |> render(DavosCharityApiWeb.ErrorView, "400.json-api", changeset)
    end
  end
end
