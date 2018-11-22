defmodule DavosCharityApi.Repo.Migrations.DonorHistory do
  use Ecto.Migration

  def change do
    create table(:donor_histories) do
      add :amount, :integer
      add :status, :string
      add :history_type, :string
      add :frequency, :string
      add :before_amount, :integer
      add :after_amount, :integer
      add :before_frequency, :string
      add :after_frequency, :string
      add :donor_id, references(:donors)
      add :ongoing_donation_id, references(:donation_ongoing)
      add :payment_id, references(:donation_payments)
      timestamps()
    end
  end
end
