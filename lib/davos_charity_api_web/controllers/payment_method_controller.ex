defmodule DavosCharityApiWeb.PaymentMethodController do
  use DavosCharityApiWeb, :controller

  alias DavosCharityApi.Donor
  alias DavosCharityApi.Donor.PaymentMethod
  alias DavosCharityApi.Donation

  plug :authenticate_donor when action in [:show]

  def show(conn, %{:current_donor => current_donor, "id" => id}) do
    payment_method = Donor.get_payment_method!(id)

    cond do
      payment_method.donor_id == current_donor.id ->
        conn
        |> render("show.json-api", data: payment_method)
      true ->
        access_error conn
    end
  end

  def create(conn, %{"data" => data = %{"type" => "payment-methods", "attributes" => _params}}) do
    data = data
    |> JaSerializer.Params.to_attributes

    case Donor.create_payment_method(data) do
      {:ok, %PaymentMethod{} = payment_method} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", Routes.payment_method_path(conn, :show, payment_method))
        |> render("show.json-api", data: payment_method)
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:bad_request)
        |> render(DavosCharityApiWeb.ErrorView, "400.json-api", changeset)
    end
  end

  def update(conn, %{"id" => id, "data" => data = %{"type" => "payment-methods", "attributes" => _params}}) do
    data = JaSerializer.Params.to_attributes(data)
    payment_method = Donor.get_payment_method!(id)

    case Donor.update_payment_method(payment_method, data) do
      {:ok, %paymentMethod{} = ongoing} ->
        conn
        |> render("show.json-api", data: payment_method)
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(DavosCharityApiWeb.ErrorView, "400.json-api", changeset)
    end
  end

  def payment_methods_for_donor(conn, %{"donor_id" => donor_id}) do
    payments = Donor.list_payment_methods_for_donor(donor_id)
    render(conn, "index.json-api", data: payments)
  end

  def payment_method_for_ongoing_donation(conn, %{"ongoing_donation_id" => ongoing_donation_id}) do
    payment_method = Donation.get_payment_method_for_ongoing_donation(ongoing_donation_id)
    render(conn, "show.json-api", data: payment_method)
  end
end
