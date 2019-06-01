defmodule DavosCharityApi.Repo.Migrations.CreateDonors do
  use Ecto.Migration

  def change do
    create table(:donors) do
      add :fname, :string
      add :lname, :string
      add :email, :string
      add :password_hash, :string
      timestamps()
    end

  end
end
