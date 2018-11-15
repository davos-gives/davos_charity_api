defmodule DavosCharityApiWeb.Router do
  use DavosCharityApiWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json", "json-api"]
    plug JaSerializer.ContentTypeNegotiation
    plug JaSerializer.Deserializer
  end

  scope "/", DavosCharityApiWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/api", DavosCharityApiWeb do
    pipe_through :api

    get "/donors/me", DonorController, :show_current

    resources "/donors", DonorController, except: [:new, :edit]
    resources "/payment-methods", PaymentMethodController, except: [:new, :edit]
    resources "/addresses", AddressController, except: [:new, :edit]
    resources "/ongoing-donations", OngoingDonationController, except: [:new, :edit]
    resources "/campaigns", CampaignController, except: [:new, :edit]
    resources "/organizations", OrganizationController, except: [:new, :edit]
    resources "/relationships", DonorOrganizationRelationshipController, except: [:new, :edit]

    post "/session", SessionController, :create

    get "/donors/:donor_id/addresses", AddressController, :addresses_for_donor
    get "/donors/:donor_id/payment-methods", PaymentMethodController, :payment_methods_for_donor
    get "/donors/:donor_id/ongoing-donations", OngoingDonationController, :ongoing_donations_for_donor
    get "/donors/:donor_id/payments", PaymentController, :payments_for_donor

    get "/ongoing-donations/:ongoing_donation_id/donor", DonorController, :donor_for_ongoing_donation
    get "/ongoing-donations/:ongoing_donation_id/payment-method", PaymentMethodController, :payment_method_for_ongoing_donation
    get "/ongoing-donations/:ongoing_donation_id/campaign", CampaignController, :campaign_for_ongoing_donation

    get "/addresses/:address_id/donor", DonorController, :donor_for_address
    get "/payment-methods/:payment_method_id/donor", DonorController, :donor_for_payment_method

    get "/campaigns/:campaign_id/organization", OrganizationController, :get_organization_for_campaign
    get "/organizations/:organization_id/campaigns", CampaignController, :campaigns_for_organization

    get "/relationships/:relationship_id/donor", DonorController, :get_donor_for_relationship
    get "/relationships/:relationship_id/organization", OrganizationController, :get_organization_for_relationship
  end
end
