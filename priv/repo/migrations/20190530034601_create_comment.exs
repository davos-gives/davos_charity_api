defmodule DavosCharityApi.Repo.Migrations.CreateComment do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :body, :text
      add :donor_id, references(:donors)
      add :user_id, references(:users)
      timestamps()
    end
  end
end
