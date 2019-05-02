defmodule DavosCharityApi.Repo.Migrations.AddExpiryToVaultCards do
  use Ecto.Migration

  def change do
    alter table(:donor_vault_card) do
      add :expiry_month, :string
      add :expiry_year, :string
    end
  end
end
