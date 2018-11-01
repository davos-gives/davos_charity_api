defmodule DavosCharityApi.Repo.Migrations.CreateForms do
  use Ecto.Migration

  def change do
    create table(:forms) do
      add :name, :string
      add :description, :text
      add :goal, :integer
      add :end_date, :string
      add :go_back_url, :string
      add :font, :string
      add :size, :string
      add :colour, :string

      timestamps()
    end
  end
end
