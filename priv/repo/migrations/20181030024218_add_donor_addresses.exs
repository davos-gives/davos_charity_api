defmodule DavosCharityApi.Repo.Migrations.AddDonorAddresses do
  use Ecto.Migration

  def change do
    create table(:donor_addresses) do
      add :name, :string
      add :address_1, :string
      add :address_2, :string
      add :postal_code, :string
      add :city, :string
      add :province, :string
      add :country, :string
      add :donor_id, references(:donors)

      timestamps()

    end
  end
end
