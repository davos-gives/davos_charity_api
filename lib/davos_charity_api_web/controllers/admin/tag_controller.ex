defmodule DavosCharityApiWeb.Admin.TagController do
  use DavosCharityApiWeb, :controller

  alias DavosCharityApi.Donor
  alias DavosCharityApi.Donor.Tag

  import Ecto.Changeset

  import IEx

  def changeset(%Tag{} = model, attrs) do
    model
    |> cast(attrs, [:name])
  end

  def tags_for_donor(conn, %{"donor_id" => donor_id}) do
    tags = Donor.list_tags_for_donor(donor_id)
    render(conn, "index.json-api", data: tags)
  end


  def create(conn, %{"data" => data = %{"type" => "tags", "attributes" => _params}}) do
    data = data
    |> JaSerializer.Params.to_attributes

    donor = Donor.get_donor!(data["donor_id"])

    case Donor.get_tag_by_name!(data["name"]) do
      %Tag{} = tag ->
        case Donor.update_tag(tag, donor) do
          {:ok, %Tag{} = tag} ->
            conn
            |> put_status(:created)
            |> put_resp_header("location", Routes.tag_path(conn, :show, tag))
            |> render("show.json-api", data: tag)
          {:error, %Ecto.Changeset{} = changeset} ->
            conn
            |> put_status(:bad_request)
            |> render(DavosCharityApiWeb.ErrorView, "400.json-api", changeset)
        end
      _ ->
      case Donor.create_tag(data, donor) do
        {:ok, %Tag{} = tag} ->
          conn
          |> put_status(:created)
          |> put_resp_header("location", Routes.tag_path(conn, :show, tag))
          |> render("show.json-api", data: tag)
        {:error, %Ecto.Changeset{} = changeset} ->
          conn
          |> put_status(:bad_request)
          |> render(DavosCharityApiWeb.ErrorView, "400.json-api", changeset)
      end
    end
  end

  def update(conn, %{"data" => data = %{"type" => "tags", "attributes" => _params}}) do

    data = data
    |> JaSerializer.Params.to_attributes

    donor = Donor.get_donor!(data["donor_id"])

    with {1,_} <- Donor.remove_tag(data) do
      send_resp(conn, :no_content, "")
    end
  end

end
