defmodule DavosCharityApi.Repo.Migrations.AddDonorPaymentOptions do
  use Ecto.Migration

  def change do
    create table(:donor_payment_methods) do
      add :name, :string
      add :type, :string
      add :number, :string
      add :expiry, :string
      add :cvv, :integer

      add :donor_id, references(:donors)
      timestamps()
    end

  end
end
