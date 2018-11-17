defmodule DavosCharityApiWeb.OngoingDonationController do
  use DavosCharityApiWeb, :controller

  alias DavosCharityApi.Donation
  alias DavosCharityApi.Donation.Ongoing

  plug :authenticate_donor when action in [:delete]


  def show(conn, %{"id" => id}) do
    donation = Donation.get_ongoing_donation!(id)
    render(conn, "show.json-api", data: donation)
  end

  def index(conn, _params) do
    ongoing_donations = Donation.list_ongoing_donations()
    render(conn, "index.json-api", data: ongoing_donations)
  end

  def create(conn, %{"data" => data = %{"type" => "ongoing-donations", "attributes" => _params}}) do
    data = data
    |> JaSerializer.Params.to_attributes

    case Donation.create_ongoing_donation(data) do
      {:ok, %Ongoing{} = ongoing} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", Routes.ongoing_donation_path(conn, :show, ongoing))
        |> render("show.json-api", data: ongoing)
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:bad_request)
        |> render(DavosCharityApiWeb.ErrorView, "400.json-api", changeset)
    end
  end

  def update(conn, %{"id" => id, "data" => data = %{"type" => "ongoing-donations", "attributes" => _params}}) do
    data = JaSerializer.Params.to_attributes(data)
    ongoing_donation = Donation.get_ongoing_donation!(id)

    case Donation.update_ongoing_donation(ongoing_donation, data) do
      {:ok, %Ongoing{} = ongoing} ->
        conn
        |> render("show.json-api", data: ongoing)
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(DavosCharityApiWeb.ErrorView, "400.json-api", changeset)
    end
  end

  def delete(conn, %{:current_donor => current_donor, "id" => id}) do
    ongoing_donation = Donation.get_ongoing_donation!(id)

    cond do
      ongoing_donation.donor_ id == current_donor.id ->
        with {:ok, %Ongoing{}} <- Donation.delete_ongoing_donation(ongoing_donation) do
          send_resp(conn, :no_content, "")
        end
    true ->
      access_error conn
    end
  end

  def ongoing_donations_for_donor(conn, %{"donor_id" => donor_id}) do
    ongoing_donations = Donation.list_ongoing_donations_for_donor(donor_id)
    render(conn, "index.json-api", data: ongoing_donations)
  end

  def ongoing_donations_for_relationship(conn, %{"relationship_id" => relationship_id}) do
    ongoing_donations = Donation.list_ongoing_donations_for_relationship(relationship_id)
    render(conn, "index.json-api", data: ongoing_donations)
  end
end
