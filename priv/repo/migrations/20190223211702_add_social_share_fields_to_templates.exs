defmodule DavosCharityApi.Repo.Migrations.AddSocialShareFieldsToTemplates do
  use Ecto.Migration

  def change do
    alter table(:templates) do
      add :end_month, :string
      add :end_year, :string
      add :facebook_share, :string
      add :twitter_share, :string
      add :email_share, :string
      add :linkedin_share, :string
    end
  end
end
