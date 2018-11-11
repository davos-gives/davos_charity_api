defmodule DavosCharityApi.Repo.Migrations.CreatePayments do
  use Ecto.Migration

  def change do
    create table(:donation_payments) do
      add :amount, :integer
      add :donor_id, references(:donors)
      add :campaign_id, references(:charity_fundraising_campaigns)
      add :ongoing_donation_id, references(:donation_ongoing)
      timestamps()
    end
  end
end
