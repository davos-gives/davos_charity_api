defmodule DavosCharityApi.Repo.Migrations.CreateSignatureModel do
  use Ecto.Migration

  def change do
    create table(:signatures) do
      add :url, :string
      add :category, :string
      timestamps()
    end
  end
end
