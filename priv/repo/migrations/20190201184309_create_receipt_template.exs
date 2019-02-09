defmodule DavosCharityApi.Repo.Migrations.CreateReceiptTemplate do
  use Ecto.Migration

  def change do
    create table(:receipt_templates) do
      add :logo, :string
      add :header, :string
      add :description, :text
      add :signature, :string
      add :font, :string
      add :primary_colour, :string
      add :secondary_colour, :string
      timestamps()
    end
  end
end
