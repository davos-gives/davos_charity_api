defmodule DavosCharityApi.Repo.Migrations.AddFrequencyToPayments do
  use Ecto.Migration

  def change do
    alter table(:donation_payments) do
      add :frequency, :string
    end
  end
end
