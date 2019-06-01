defmodule DavosCharityApi.Repo.Migrations.AddVaultCardToOngoingDonation do
  use Ecto.Migration

  def change do
    alter table(:donation_ongoing) do
      add :vault_card_id, references(:donor_vault_card)
    end
  end
end
