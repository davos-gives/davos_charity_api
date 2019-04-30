defmodule DavosCharityApi.Repo.Migrations.AddDonorToDonorVaultCard do
  use Ecto.Migration

  def change do
    alter table(:donor_vault_card) do
      add :donor_id, references(:donors)
    end
  end
end
