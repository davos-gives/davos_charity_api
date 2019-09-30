defmodule DavosCharityApi.Repo.Migrations.AddSourceToOngoing do
  use Ecto.Migration

  def change do
    alter table(:donation_ongoing) do
      add :source, :string
    end
  end
end
