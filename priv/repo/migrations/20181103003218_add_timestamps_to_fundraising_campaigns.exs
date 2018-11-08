defmodule DavosCharityApi.Repo.Migrations.AddTimestampsToFundraisingCampaigns do
  use Ecto.Migration

  def change do
    alter table(:charity_fundraising_campaigns) do
      timestamps()
    end
  end
end
