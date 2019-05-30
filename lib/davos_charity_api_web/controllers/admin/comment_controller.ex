defmodule DavosCharityApiWeb.Admin.CommentController do
  use DavosCharityApiWeb, :controller

  alias DavosCharityApi.Donor
  alias DavosCharityApi.Organization.{Management, Comment}

  import IEx

  plug :authenticate_user when action in [:create]

  def create(conn, %{:current_user => current_user, "data" => data = %{"type" => "comments", "attributes" => _params}}) do
    data = data
    |> JaSerializer.Params.to_attributes
    |> Map.put("user_id", current_user.id)

    case Management.create_comment(data) do
      {:ok, %Comment{} = comment} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", Routes.comment_path(conn, :show, comment))
        |> render("show.json-api", data: comment)
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:bad_request)
        |> render(DavosCharityApiWeb.ErrorView, "400.json-api", changeset)
    end
  end

  def comments_for_donor(conn, %{"donor_id" => donor_id}) do
    comments = Donor.list_comments_for_donor(donor_id)
    render(conn, "index.json-api", data: comments)
  end
end
