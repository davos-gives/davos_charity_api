defmodule DavosCharityApi.Repo.Migrations.CreateUserVault do
  use Ecto.Migration

  def change do
    create table(:donor_vault) do
      add :iats_id, :string
      add :donor_id, references(:donors)
      timestamps()
    end
  end
end
