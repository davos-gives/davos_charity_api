defmodule DavosCharityApi.Repo.Migrations.AddFormToPayment do
  use Ecto.Migration

  def change do
    alter table(:donation_payments) do
      add :form_id, references(:forms)
    end
  end
end
