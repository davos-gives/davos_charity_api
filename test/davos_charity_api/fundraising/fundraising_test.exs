defmodule DavosCharityApi.FundraisingTest do
  use DavosCharityApi.DataCase

  alias DavosCharityApi.Fundraising
  alias DavosCharityApi.Fundraising.{
    Campaign,
    Form
  }

  describe "create_campaign/1" do

    @valid_attrs %{
      name: "Help us find a new home",
      type: "single",
      status: "active",
    }

    @invalid_attrs %{}

    test "with valid data creates campaign and attaches it to organization" do
      organization = organization_fixture()

      {:ok, %Campaign{id: id} = campaign} = Fundraising.create_campaign(Map.put(@valid_attrs, :organization_id, organization.id))

      assert campaign.name == "Help us find a new home"
      assert campaign.type == "single"
      assert campaign.status == "active"

      assert [%Campaign{id: ^id}] = Fundraising.list_campaigns_for_organization(organization.id)
    end

    test "with invalid data does not create the campaign" do
      assert {:error, _changeset} = Fundraising.create_campaign(@invalid_attrs)
    end
  end

end
