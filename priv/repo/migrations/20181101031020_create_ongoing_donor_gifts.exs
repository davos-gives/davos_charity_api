defmodule DavosCharityApi.Repo.Migrations.CreateOngoingDonorGifts do
  use Ecto.Migration

  def change do
    create table(:donation_ongoing) do
      add :frequency, :string
      add :status, :string
      add :amount, :integer

      add :donor_id, references(:donors)
      timestamps()
    end
  end
end
