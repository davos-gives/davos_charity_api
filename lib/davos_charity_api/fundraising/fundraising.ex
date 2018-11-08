defmodule DavosCharityApi.Fundraising do
  use Ecto.Schema

  alias DavosCharityApi.Repo
  alias DavosCharityApi.Fundraising.Form
  alias DavosCharityApi.Fundraising.Campaign
  alias DavosCharityApi.Organization

  import Ecto.Query

  def create_form(attrs \\ %{}) do
    %Form{}
    |> Form.changeset(attrs)
    |> Repo.insert
  end

  def get_form!(id), do: Repo.get!(Form, id)

  def create_campaign(attrs \\ %{}) do
    %Campaign{}
    |> Campaign.changeset(attrs)
    |> Repo.insert
  end

  def list_campaigns_for_organization(organization_id) do
    Campaign
    |> where([cmp], cmp.organization_id == ^organization_id)
    |> Repo.all
  end


end
