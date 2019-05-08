defmodule DavosCharityApiWeb.AddressController do
  use DavosCharityApiWeb, :controller

  alias DavosCharityApi.Donor
  alias DavosCharityApi.Donor.Address

  alias IEx

  plug :authenticate_donor when action in [:show, :create, :index, :delete]

  def show(conn, %{:current_donor => current_donor, "id" => id}) do
    address = Donor.get_address!(id)

    cond do
      address.donor_id == current_donor.id ->
        conn
        |> render("show.json-api", data: address)
      true ->
        access_error conn
    end
  end

  def index(conn, %{:current_donor => current_donor}) do
    addresses = Donor.list_addresses_for_donor(current_donor.id)
    render(conn, "index.json-api", data: addresses)
  end

  def create(conn, %{:current_donor => current_donor, "data" => data = %{"type" => "addresses", "attributes" => _params}}) do
    data = data
    |> JaSerializer.Params.to_attributes()
    |> Map.put("donor_id", current_donor.id)
    |> Map.put("country", "Canada")

    case Donor.create_address(data) do
      {:ok, %Address{} = address} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", Routes.address_path(conn, :show, address))
        |> render("show.json-api", data: address)
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:bad_request)
        |> render(DavosCharityApiWeb.ErrorView, "400.json-api", changeset)
    end
  end

  def create(conn, %{"data" => data = %{"type" => "addresses", "attributes" => _params}}) do
    data = data
    |> JaSerializer.Params.to_attributes()

    case Donor.create_address(data) do
      {:ok, %Address{} = address} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", Routes.address_path(conn, :show, address))
        |> render("show.json-api", data: address)
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:bad_request)
        |> render(DavosCharityApiWeb.ErrorView, "400.json-api", changeset)
    end
  end

  def update(conn, %{"id" => id, "data" => data = %{"type" => "addresses", "attributes" => _params}}) do
    data = JaSerializer.Params.to_attributes(data)
    address = Donor.get_address!(id)

    case Donor.update_address(address, data) do
      {:ok, %Address{} = address} ->
        conn
        |> render("show.json-api", data: address)
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(DavosCharityApiWeb.ErrorView, "400.json-api", changeset)
    end
  end

  def delete(conn, %{:current_donor => current_donor, "id" => id}) do

    address = Donor.get_address!(id)
    cond do
      address.donor_id == current_donor.id ->
        with {:ok, %Address{}} <- Donor.delete_address(address) do
          send_resp(conn, :no_content, "")
        end
    true ->
      access_error conn
    end
  end

  def addresses_for_donor(conn, %{"donor_id" => donor_id}) do
    addresses = Donor.list_addresses_for_donor(donor_id)
    render(conn, "index.json-api", data: addresses)
  end
end
