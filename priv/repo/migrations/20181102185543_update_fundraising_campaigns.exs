defmodule DavosCharityApi.Repo.Migrations.UpdateFundraisingCampaigns do
  use Ecto.Migration

  def change do
    alter table(:charity_fundraising_campaigns) do
      add :organization_id, references(:organizations)
    end
  end
end
