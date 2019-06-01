defmodule DavosCharityApi.Repo.Migrations.AddDonorsAndPaymentsToReceipts do
  use Ecto.Migration

  def change do
    alter table(:receipts) do
      add :url, :string
      add :donor_id, references(:donors)
      add :payment_id, references(:donation_payments)
    end
  end
end
