defmodule DavosCharityApi.Repo.Migrations.AddImageToCampaign do
  use Ecto.Migration

  def change do
    alter table(:charity_fundraising_campaigns) do
      add :image, :string
    end
  end
end
