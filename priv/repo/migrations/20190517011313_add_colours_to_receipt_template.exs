defmodule DavosCharityApi.Repo.Migrations.AddColoursToReceiptTemplate do
  use Ecto.Migration

  def change do

    alter table(:receipt_templates) do
      add :tertiary_colour, :string
      add :quaternary_colour, :string
      add :quinary_colour, :string
    end
  end
end
