defmodule DavosCharityApi.Repo.Migrations.AddTimestampsToDonorOrganizationRelationship do
  use Ecto.Migration

  def change do
    alter table(:donor_organization_relationships) do
      timestamps default: fragment("NOW()")
    end
  end
end
