defmodule DavosCharityApi.Repo.Migrations.CreateDonorTag do
  use Ecto.Migration

  def change do
    create table(:donor_tags, primary_key: false) do
      add :donor_id, references(:donors)
      add :tag_id, references(:tags)
    end

    create unique_index(:donor_tags, [:donor_id, :tag_id])
  end
end
