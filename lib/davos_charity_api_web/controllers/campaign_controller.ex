defmodule DavosCharityApiWeb.CampaignController do
  use DavosCharityApiWeb, :controller

  alias DavosCharityApi.Fundraising
  alias DavosCharityApi.Fundraising.Campaign

  def index(conn, _params) do
    campaigns = Fundraising.list_campaigns
    render(conn, "index.json-api", data: campaigns)
  end

  def show(conn, %{"id" => id}) do
    campaign = Fundraising.get_campaign!(id)
    render(conn, "show.json-api", data: campaign)
  end

  def create(conn, %{"data" => data = %{"type" => "fundraising-campaigns", "attributes" => _params}}) do
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

  def update(conn, %{"id" => id, "data" => data = %{"type" => "fundraising-campaigns", "attributes" => _params}}) do
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
end
