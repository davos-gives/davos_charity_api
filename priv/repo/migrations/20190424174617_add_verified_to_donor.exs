defmodule DavosCharityApi.Repo.Migrations.AddVerifiedToDonor do
  use Ecto.Migration

  def change do
    alter table(:donors) do
      add :verified, :boolean, default: false
    end
  end
end
