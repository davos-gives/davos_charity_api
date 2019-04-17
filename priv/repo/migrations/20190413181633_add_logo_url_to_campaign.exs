defmodule DavosCharityApi.Repo.Migrations.AddLogoUrlToCampaign do
  use Ecto.Migration

  def change do
    alter table(:charity_fundraising_campaigns) do
      add :logo_url, :string
    end
  end
end
