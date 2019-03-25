defmodule DavosCharityApi.Repo.Migrations.AddFieldsToCampaigns do
  use Ecto.Migration

  def change do
    alter table(:charity_fundraising_campaigns) do
      add :description, :string
      add :has_end_date, :boolean
      add :go_back_url, :string
      add :image_url, :string
      add :font, :string
      add :end_date, :string
      add :end_month, :string
      add :end_year, :string
      add :primary_colour, :string
      add :secondary_colour, :string
      add :tertiary_colour, :string
      add :quaternary_colour, :string
      add :quinary_colour, :string
      add :facebook_share, :boolean
      add :linkedin_share, :boolean
      add :twitter_share, :boolean
      add :email_share, :boolean
      add :published, :boolean
      add :template_id, references(:templates)
    end
  end
end
