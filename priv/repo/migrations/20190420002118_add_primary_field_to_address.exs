defmodule DavosCharityApi.Repo.Migrations.AddPrimaryFieldToAddress do
  use Ecto.Migration

  def change do
    alter table(:donor_addresses) do
      add :primary, :boolean
    end
  end
end
