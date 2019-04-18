defmodule DavosCharityApi.Repo.Migrations.AddReferenceToOngoing do
  use Ecto.Migration

  def change do
    alter table(:donation_ongoing) do
      add :reference_number, :string
    end
  end
end
