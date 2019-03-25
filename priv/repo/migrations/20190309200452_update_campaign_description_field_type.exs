defmodule DavosCharityApi.Repo.Migrations.UpdateCampaignDescriptionFieldType do
  use Ecto.Migration

    def change do
      alter table(:charity_fundraising_campaigns) do
      modify :description, :text
    end
  end
end
