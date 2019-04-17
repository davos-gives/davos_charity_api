defmodule DavosCharityApi.Fundraising do
  use Ecto.Schema

  alias DavosCharityApi.Repo
  alias DavosCharityApi.Fundraising.Form
  alias DavosCharityApi.Fundraising.Campaign
  alias DavosCharityApi.Fundraising.Template
  alias DavosCharityApi.Fundraising.ReceiptTemplate
  alias DavosCharityApi.Fundraising.Photo
  alias DavosCharityApi.Fundraising.Logo
  alias DavosCharityApi.Fundraising
  alias DavosCharityApi.Organization

  import Ecto.Query

  def create_form(attrs \\ %{}) do
    %Form{}
    |> Form.changeset(attrs)
    |> Repo.insert
  end

  def get_form!(id), do: Repo.get!(Form, id) |> Repo.preload(:payments)

  def get_template!(id), do: Repo.get!(Template, id)

  def get_photo!(id), do: Repo.get!(Photo, id)

  def get_logo!(id), do: Repo.get(Logo, id)

  def list_photos, do: Repo.all(Photo)

  def list_logos, do: Repo.all(Logo)

  def create_photo(attrs \\ %{}) do
    %Photo{}
    |> Photo.changeset(attrs)
    |> Repo.insert
  end

  def create_logo(attrs \\ %{}) do
    %Logo{}
    |> Logo.changeset(attrs)
    |> Repo.insert
  end

  def get_receipt_template!(id), do: Repo.get!(ReceiptTemplate, id)

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

  def get_template_for_campaign(campaign_id) do
    campaign = Fundraising.get_campaign!(campaign_id)
    campaign = Repo.preload(campaign, :template)
    campaign.template
  end

  def get_template_id_for_campaign(campaign_id) do
    campaign = Fundraising.get_campaign!(campaign_id)
    campaign = Repo.preload(campaign, :template)
    campaign.template.id
  end
end
