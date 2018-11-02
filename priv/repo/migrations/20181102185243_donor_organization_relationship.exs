defmodule DavosCharityApi.Repo.Migrations.DonorOrganizationRelationship do
  use Ecto.Migration

  def change do
    create table(:donor_organization_relationships) do
      add :donor_id, references(:donors)
      add :organization_id, references(:organizations)
    end
  end
end
