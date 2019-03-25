defmodule DavosCharityApi.Repo.Migrations.AddFieldsToCampaign do
  use Ecto.Migration

  def change do
    alter table(:charity_fundraising_campaigns) do
      add :has_goal, :boolean
      add :show_goal, :boolean
      add :goal, :integer
    end
  end
end
