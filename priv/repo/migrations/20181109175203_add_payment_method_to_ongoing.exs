defmodule DavosCharityApi.Repo.Migrations.AddPaymentMethodToOngoing do
  use Ecto.Migration

  def change do
    alter table(:donation_ongoing) do
      add :payment_method_id, references(:donor_payment_methods)
    end
  end
end
