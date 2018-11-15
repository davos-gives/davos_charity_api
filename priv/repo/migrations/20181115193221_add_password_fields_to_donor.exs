defmodule DavosCharityApi.Repo.Migrations.AddPasswordFieldsToDonor do
  use Ecto.Migration

  def change do
    alter table(:donors) do
      add :password_hash, :string
    end
  end
end
