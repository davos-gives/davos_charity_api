defmodule DavosCharityApi.Repo.Migrations.UpdateFundraisingForm do
  use Ecto.Migration

  def change do
    create table(:charity_fundraising_campaigns) do
      add :status, :string
      add :type, :string
      add :name, :string
    end
  end
end
