defmodule DavosCharityApi.Fundraising do
  use Ecto.Schema

  alias DavosCharityApi.Repo
  alias DavosCharityApi.Fundraising.Form
  alias DavosCharityApi.Fundraising.Campaign
  alias DavosCharityApi.Fundraising
  alias DavosCharityApi.Organization

  import Ecto.Query

  def create_form(attrs \\ %{}) do
    %Form{}
    |> Form.changeset(attrs)
    |> Repo.insert
  end

  def get_form!(id), do: Repo.get!(Form, id)

  def list_campaigns, do: Repo.all(Campaign)

  def get_campaign!(id), do: Repo.get!(Campaign, id)

  def create_campaign(attrs \\ %{}) do
    %Campaign{}
    |> Campaign.changeset(attrs)
    |> Repo.insert
  end

  def update_campaign(%Campaign{} = campaign, attrs) do
    campaign
    |> Campaign.changeset(attrs)
    |> Repo.update
  end

  def list_campaigns_for_organization(organization_id) do
    Campaign
    |> where([cmp], cmp.organization_id == ^organization_id)
    |> Repo.all
  end

  def get_organization_for_campaign(campaign_id) do
    campaign = Fundraising.get_campaign!(campaign_id)
    campaign = Repo.preload(campaign, :organization)
    campaign.organization
  end
end
