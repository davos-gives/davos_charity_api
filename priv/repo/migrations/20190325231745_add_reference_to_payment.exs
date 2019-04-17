defmodule DavosCharityApi.Repo.Migrations.AddReferenceToPayment do
  use Ecto.Migration

  def change do
    alter table(:donation_payments) do
      add :reference_number, :string
    end
  end
end
