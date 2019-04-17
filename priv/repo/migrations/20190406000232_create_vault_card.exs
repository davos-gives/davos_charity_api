defmodule DavosCharityApi.Repo.Migrations.CreateVaultCard do
  use Ecto.Migration

  def change do
    create table(:donor_vault_card) do
      add :iats_id, :string
      add :name, :string
      add :vault_id, references(:donor_vault)
      timestamps()
    end

  end
end
