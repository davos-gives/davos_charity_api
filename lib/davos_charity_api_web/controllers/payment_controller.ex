defmodule DavosCharityApiWeb.PaymentController do
  use DavosCharityApiWeb, :controller

  alias DavosCharityApi.Donor
  alias DavosCharityApi.Donation
  alias DavosCharityApi.Donation.Payment

  alias IEx

  def create(conn, %{"data" => data = %{"type" => "payments", "attributes" => %{"vault_id" => _params}}}) do
    data = data
    |> JaSerializer.Params.to_attributes()

    case Donation.create_vault_donation(data) do

      {:ok, %{created_payment: {:ok, %Payment{} = payment}}} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", Routes.address_path(conn, :show, payment))
        |> render("show.json-api", data: payment)
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:bad_request)
        |> render(DavosCharityApiWeb.ErrorView, "400,json-api", changeset)
    end
  end

  def create(conn, %{"data" => data = %{"type" => "payments", "attributes" => _params}}) do
    data = data
    |> JaSerializer.Params.to_attributes()

    case Donation.create_donation(data) do

      {:ok, %{created_payment: {:ok, %Payment{} = payment}}} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", Routes.address_path(conn, :show, payment))
        |> render("show.json-api", data: payment)
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:bad_request)
        |> render(DavosCharityApiWeb.ErrorView, "400,json-api", changeset)
    end
  end

  def payments_for_donor(conn, %{"donor_id" => donor_id}) do
    payments = Donation.list_payments_for_donor(donor_id)
    render(conn, "index.json-api", data: payments)
  end

  def payments_for_ongoing_relationship(conn, %{"relationship_id" => relationship_id}) do
    payments = Donation.list_payments_for_relationship(relationship_id)
    render(conn, "index.json-api", data: payments)
  end

end
