defmodule DavosCharityApiWeb.CampaignView do
  use DavosCharityApiWeb, :view

  import IEx

  def cents_to_dollars(cents) do
    cents / 100 |> Number.Currency.number_to_currency()
  end

  def defaulted_name(conn) do
    conn.assigns.campaign.name || "Help us find a new home"
  end

  def defaulted_description(conn) do
    raw conn.assigns.campaign.description || "<div>After 18 years in the same location, the Barks &amp; Meows Shelter is facing a move. In addition to finding a suitable location that will permit us to continue our work, major renovations and modifications may well be required. You can assist us in our quest to raise funds by giving to our campaign.</div><div><br>Help our shelter reach our goal; our survival is in your hands. Now more than ever we need your involvement so that our quest of helping abandoned animals can continue.</div>"
  end

  def amount_raised(conn) do
    conn.assigns.campaign.total_donations
  end

  def number_of_donors(conn) do
    conn.assigns.campaign.number_of_donors
  end

  def defaulted_goal(conn) do
    conn.assigns.campaign.goal * 100 || 10000
  end

  def show_goal(conn) do
    conn.assigns.campaign.show_goal || "hidden"
  end

  def percent_loaded(conn) do
    conn.assigns.campaign.total_donations / conn.assigns.campaign.goal
  end

  def defaulted_image(conn) do
    conn.assigns.campaign.image_url || "/images/dogs.jpg"
  end

  def defaulted_logo(conn) do
    conn.assigns.campaign.logo_url || "/images/logo.png"
  end

  def show_social_share(conn) do
    (conn.assigns.campaign.facebook_share == true || conn.assigns.campaign.twitter_share == true || conn.assigns.campaign.email_share == true || conn.assigns.campaign.linkedin_share == true) || "display: none"
  end

  def defaulted_facebook_share(conn) do
    conn.assigns.campaign.facebook_share || "display: none"
  end

  def defaulted_twitter_share(conn) do
    conn.assigns.campaign.twitter_share || "display: none"
  end

  def defaulted_linkedin_share(conn) do
    conn.assigns.campaign.linkedin_share || "display: none"
  end

  def defaulted_email_share(conn) do
    conn.assigns.campaign.email_share || "display: none"
  end
end
