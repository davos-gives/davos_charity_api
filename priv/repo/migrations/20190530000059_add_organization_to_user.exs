defmodule DavosCharityApi.Repo.Migrations.AddOrganizationToUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :organization_id, references(:organizations)
    end

  end
end
