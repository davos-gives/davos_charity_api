defmodule DavosCharityApi.Repo.Migrations.AddNameTypeToVaultCard do
  use Ecto.Migration

  def change do
    alter table(:donor_vault_card) do
      add :card_type, :string
      add :last_four_digits, :string
    end
  end
end
