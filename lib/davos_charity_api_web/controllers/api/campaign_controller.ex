defmodule DavosCharityApiWeb.Api.CampaignController do
  use DavosCharityApiWeb, :controller

  alias DavosCharityApi.Fundraising
  alias DavosCharityApi.Fundraising.Campaign
  alias DavosCharityApi.Donation

  alias IEx

  def index(conn, _params) do
    campaigns = Fundraising.list_campaigns
    render(conn, "index.json-api", data: campaigns)
  end

  def show(conn, %{"campaign_id" => campaign_id}) do
    campaign = Fundraising.get_campaign!(campaign_id)
    render("show.json-api", data: campaign)
  end

  def create(conn, %{"data" => data = %{"type" => "campaigns", "attributes" => _params}}) do
    data = data
    |> JaSerializer.Params.to_attributes

    case Fundraising.create_campaign(data) do
      {:ok, %Campaign{} = campaign} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", Routes.campaign_path(conn, :show, campaign))
        |> render("show.json-api", data: campaign)
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:bad_request)
        |> render(DavosCharityApiWeb.ErrorView, "400.json-api", changeset)
    end
  end

  def update(conn, %{"id" => id, "data" => data = %{"type" => "campaigns", "attributes" => _params}}) do
    data = JaSerializer.Params.to_attributes(data)
    campaign = Fundraising.get_campaign!(id)

    case Fundraising.update_campaign(campaign, data) do
      {:ok, %Campaign{} = campaign} ->
        conn
        |> render("show.json-api", data: campaign)
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(DavosCharityApiWeb.ErrorView, "400.json-api", changeset)
    end
  end

  def campaigns_for_organization(conn, %{"organization_id" => organization_id}) do
    campaigns = Fundraising.list_campaigns_for_organization(organization_id)
    render(conn, "index.json-api", data: campaigns)
  end

  def campaign_for_ongoing_donation(conn, %{"ongoing_donation_id" => ongoing_donation_id}) do
    campaign = Donation.get_campaign_for_ongoing_donation(ongoing_donation_id)
    render(conn, "show.json-api", data: campaign)
  end

  def campaign_for_payment(conn, %{"payment_id" => payment_id}) do
    campaign = Donation.get_campaign_for_payment(payment_id)
    render(conn, "show.json-api", data: campaign)
  end
end
