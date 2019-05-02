defmodule DavosCharityApiWeb.Admin.SignatureController do
  use DavosCharityApiWeb, :controller

  alias DavosCharityApi.Fundraising
  alias DavosCharityApi.Fundraising.Signature


  def show(conn, %{"id" => id}) do
    logo = Fundraising.get_signature!(id)
    render(conn, "show.json-api", data: logo)
  end

  def index(conn, _params) do
    signatures = Fundraising.list_signatures()
    render(conn, "index.json-api", data: signatures)
  end

  def create(conn, %{"data" => data = %{"type" => "signatures", "attributes" => _params}}) do
    data = data
    |> JaSerializer.Params.to_attributes

    case Fundraising.create_signature(data) do
      {:ok, %Signature{} = signature} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", Routes.signature_path(conn, :show, signature))
        |> render("show.json-api", data: signature)
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:bad_request)
        |> render(DavosCharityApiWeb.ErrorView, "400.json-api", changeset)
    end
  end
end
