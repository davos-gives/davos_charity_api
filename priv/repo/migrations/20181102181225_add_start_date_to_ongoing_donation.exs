defmodule DavosCharityApi.Repo.Migrations.AddStartDateToOngoingDonation do
  use Ecto.Migration

  def change do
    alter table(:donation_ongoing) do
      add :start_date, :utc_datetime
    end
  end
end
