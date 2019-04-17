defmodule DavosCharityApi.Repo.Migrations.CreateLogos do
  use Ecto.Migration

  def change do
    create table(:logos) do
      add :url, :string
      add :category, :string
      timestamps()
    end
  end
end
