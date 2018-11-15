defmodule DavosCharityApi.Repo.Migrations.AddCampaignToOngoingDonation do
  use Ecto.Migration

  def change do
    alter table(:donation_ongoing) do
      add :campaign_id, references(:charity_fundraising_campaigns)
    end
  end
end
