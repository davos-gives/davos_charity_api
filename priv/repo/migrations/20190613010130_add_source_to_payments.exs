defmodule DavosCharityApi.Repo.Migrations.AddSourceToPayments do
  use Ecto.Migration

  def change do
    alter table(:donation_payments) do
      add :source, :string
    end
  end
end
