defmodule DavosCharityApi.Repo.Migrations.CreateDonorTags do
  use Ecto.Migration

  def change do
    create table(:tags) do
      add :name, :string
      timestamps()
    end

    create unique_index(:tags, [:name])
  end
end
