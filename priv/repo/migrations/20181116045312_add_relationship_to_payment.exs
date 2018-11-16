defmodule DavosCharityApi.Repo.Migrations.AddPaymentToRelationship do
  use Ecto.Migration

  def change do
    alter table(:donation_payments) do
      add :donor_organization_relationship_id, references(:donor_organization_relationships)
    end
  end
end
