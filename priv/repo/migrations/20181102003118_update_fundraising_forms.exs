defmodule DavosCharityApi.Repo.Migrations.UpdateFundraisingForm do
  use Ecto.Migration

  def change do
    alter table(:forms) do
      add :status, :string
      add :campaign_id, references(:charity_fundraising_campaigns)
    end
  end
end
