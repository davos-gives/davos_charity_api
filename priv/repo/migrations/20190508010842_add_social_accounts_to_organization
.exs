defmodule Elixir.DavosCharityApi.Repo.Migrations.AddSocialAccountsToOrganization do
  use Ecto.Migration

  def change do
    alter table(:organizations) do
      add :facebook_handle, :string
      add :twitter_handle, :string
      add :instagram_handle, :string
    end
  end
end
