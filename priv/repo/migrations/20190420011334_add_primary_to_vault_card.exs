defmodule DavosCharityApi.Repo.Migrations.AddPrimaryToVaultCard do
  use Ecto.Migration

  def change do
    alter table(:donor_vault_card) do
      add :primary, :boolean
    end
  end
end
