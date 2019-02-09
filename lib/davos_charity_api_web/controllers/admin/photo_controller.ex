defmodule DavosCharityApiWeb.Admin.PhotoController do
  use DavosCharityApiWeb, :controller

  alias DavosCharityApi.Fundraising
  alias DavosCharityApi.Fundraising.Photo


  def show(conn, %{"id" => id}) do
    photo = Fundraising.get_photo!(id)
    render(conn, "show.json-api", data: photo)
  end

  def index(conn, _params) do
    photos = Fundraising.list_photos()
    render(conn, "index.json-api", data: photos)
  end

  def create(conn, %{"data" => data = %{"type" => "photos", "attributes" => _params}}) do
    data = data
    |> JaSerializer.Params.to_attributes

    case Fundraising.create_photo(data) do
      {:ok, %Photo{} = photo} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", Routes.photo_path(conn, :show, photo))
        |> render("show.json-api", data: photo)
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:bad_request)
        |> render(DavosCharityApiWeb.ErrorView, "400.json-api", changeset)
    end
  end
end
