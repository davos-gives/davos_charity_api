defmodule DavosCharityApiWeb.DonorController do
  use DavosCharityApiWeb, :controller

  alias DavosCharityApi.Donor
  alias DavosCharityApi.Donation

  alias DavosCharityApi.Mailer
  alias DavosCharityApi.Email

  import IEx

  plug :authenticate_donor when action in [:show_current]

  def show_current(conn, %{current_donor: donor}) do
    conn
    |> render("show.json-api", data: donor, opts: [include: conn.query_params["include"]])

  end

  def show(conn, %{"id" => id}) do
    donor = Donor.get_donor!(id)
    render(conn, "show.json-api", data: donor)
  end

  def donor_by_email(conn, %{"email_address" => email_address}) do
    donor = Donor.get_donor_by_email!(email_address)

    conn
    |> put_status(:no_content)
    |> put_resp_header("content-type", "application/vnd.api+json")
    |> send_resp(204, "")
  end



  def index(conn, params) do
    IEx.pry
    donors = Donor.list_donors()
    render(conn, "index.json-api", data: donors)
  end

  def create(conn, %{"data" => data = %{"type" => "donors", "attributes" => _params}}) do
    data = data
    |> JaSerializer.Params.to_attributes()

    case Donor.create_donor(data) do
      {:ok, %Donor{} = donor} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", Routes.address_path(conn, :show, donor))
        |> render("show.json-api", data: donor)
        |> send_verification_email(donor)

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:bad_request)
        |> render(DavosCharityApiWeb.ErrorView, "400.json-api", changeset)
    end
  end

  def send_reset_email(conn, %{"email" => email}) do
    donor = Donor.get_donor_by_email!(email)
    token = DavosCharityApi.Donor.Token.generate_new_account_token(donor)
    Email.send_password_reset_email(donor, token)
    |> Mailer.deliver_now()

    conn
    |> put_status(:no_content)
    |> put_resp_header("content-type", "application/vnd.api+json")
    |> send_resp(204, "")
  end

  def reset_donor_password(conn, %{"token" => token, "password" => password, "passwordConfirmation" => passwordConfirmation}) do

    with {:ok, donor_id} <- DavosCharityApi.Donor.Token.verify_password_reset_token(token) do
      donor = Donor.get_donor!(donor_id)

      case Donor.update_donor(donor, %{password: password, password_confirmation: passwordConfirmation, reset: true}) do
        {:ok, %Donor{} = donor} ->
          conn
          |> put_status(:no_content)
          |> put_resp_header("content-type", "application/vnd.api+json")
          |> send_resp(204, "")

        {:error, %Ecto.Changeset{} = changeset} ->
          conn
          |> put_status(:bad_request)
          |> render(DavosCharityApiWeb.ErrorView, "400.json-api", changeset)
      end
      render(conn, "show.json-api", data: donor)
    else
      _-> render(DavosCharityApiWeb.ErrorView, "400.json-api")
    end
  end

  def send_verification_email(conn, donor) do
    token = DavosCharityApi.Donor.Token.generate_new_account_token(donor)
    Email.send_account_verification_email(donor, token)
    |> Mailer.deliver_now()

    conn
  end

  def verify_email(conn, %{"token" => token}) do
    with {:ok, donor_id} <- DavosCharityApi.Donor.Token.verify_new_account_token(token),
    %Donor{verified: false} = donor <- DavosCharityApi.Donor.get_donor!(donor_id) do
      DavosCharityApi.Donor.mark_account_as_verified(donor)
      render(conn, "show.json-api", data: donor)
    else
      _ -> render(DavosCharityApiWeb.ErrorView, "400.json-api")
    end
  end


  def donor_for_ongoing_donation(conn, %{"ongoing_donation_id" => ongoing_donation_id}) do
    donor = Donation.get_donor_for_ongoing_donation!(ongoing_donation_id)
    render(conn, "show.json-api", data: donor)
  end

  def donor_for_address(conn, %{"address_id" => address_id}) do
    donor = Donor.get_donor_for_address!(address_id)
    render(conn, "show.json-api", data: donor)
  end

  def donor_for_payment_method(conn, %{"payment_method_id" => payment_method_id}) do
    donor = Donor.get_donor_for_payment_method!(payment_method_id)
    render(conn, "show.json-api", data: donor)
  end

  def get_donor_for_relationship(conn, %{"relationship_id" => relationship_id}) do
    relationship = Donor.get_donor_for_relationship!(relationship_id)
    render(conn, "show.json-api", data: relationship)
  end
end
