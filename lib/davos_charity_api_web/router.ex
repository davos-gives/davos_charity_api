defmodule DavosCharityApiWeb.Router do
  use DavosCharityApiWeb, :router

  if Mix.env == :dev do
   forward "/sent_emails", Bamboo.SentEmailViewerPlug
 end

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers, %{"content-security-policy" => "frame-ancestors http://localhost:4300"}
  end

  pipeline :api do
    plug :accepts, ["json", "json-api"]
    plug JaSerializer.ContentTypeNegotiation
    plug JaSerializer.Deserializer
  end

  pipeline :public do
    plug :accepts, ["json"]
  end

  scope "/", DavosCharityApiWeb do
    pipe_through :browser

    get "/", PageController, :index

    get "/forms/:form_id", FormController, :show
    get "/forms/:form_id/*anything", FormController, :show

    get "/templates/:template_id", TemplateController, :show
    get "/templates/:template_id/*anything", TemplateController, :show

    get "/campaigns/:campaign_id", CampaignController, :show
    get "/campaigns/:campaign_id/*anything", CampaignController, :show

    get "/receipt_templates/:receipt_template_id", ReceiptTemplateController, :show
    get "/receipts/:receipt_id", ReceiptController, :show
    get "/export", Admin.ExportController,:get_csv_for_export
  end

  scope "/api/public", DavosCharityApiWeb do
    pipe_through :public

    post "/upload-signature", Admin.UploadSignatureController, :create
  end

  scope "/api/admin", DavosCharityApiWeb do
    pipe_through :api

    resources "/donors", Admin.DonorController, except: [:new, :edit]
    resources "/payments", Admin.PaymentController, except: [:new, :edit]
    resources "/campaigns", Admin.CampaignController, except: [:new, :edit]
    resources "/ongoing-donations", Admin.OngoingDonationController, except: [:new, :edit]
    resources "/donor-history", Admin.DonorHistoryController, except: [:new, :edit]
    resources "/photos", Admin.PhotoController, except: [:new, :edit]
    resources "/signatures", Admin.SignatureController, except: [:new, :edit]
    resources "/logos", Admin.LogoController, except: [:new, :edit]
    resources "/templates", Admin.TemplateController, except: [:new, :edit]
    resources "/receipts", Admin.ReceiptController, except: [:new, :edit]
    resources "/receipt-templates", Admin.ReceiptTemplateController, except: [:new, :edit]
    resources "/tags", Admin.TagController, except: [:new, :edit]

    get "/exports", Admin.ExportController,:get_csv_for_export

    get "/campaigns/:campaign_id/payments", Admin.PaymentController, :get_payments_for_campaign
    get "/campaigns/:campaign_id/template", Admin.TemplateController, :template_for_campaign

    get "/donors/:donor_id/payments", Admin.PaymentController, :get_payments_for_donor
    get "/donors/:donor_id/ongoing-donations", Admin.OngoingDonationController, :ongoing_donations_for_donor
    get "/donors/:donor_id/addresses", AddressController, :addresses_for_donor
    get "/donors/:donor_id/tags", Admin.TagController, :tags_for_donor

    get "/donors/:donor_id/donor-history", Admin.DonorHistoryController, :history_for_donor

    get "/payments/:payment_id/donor", Admin.DonorController, :get_donor_for_payment
    get "/payments/:payment_id/receipt", Admin.Api.ReceiptController, :get_receipt_for_payment
    get "/payments/:payment_id/campaign", Admin.CampaignController, :campaign_for_payment

    get "/ongoing-donations/:ongoing_donation_id/donor", Admin.DonorController, :donor_for_ongoing_donation
    get "/ongoing-donations/:ongoing_donation_id/payment-method", AdminPaymentMethodController, :payment_method_for_ongoing_donation
    get "/ongoing-donations/:ongoing_donation_id/campaign", Admin.CampaignController, :campaign_for_ongoing_donation

    post "/session", Admin.SessionController, :create
    get "/users/me", Admin.UserController, :show_current

  end

  scope "/api", DavosCharityApiWeb do
    pipe_through :api

    get "/donors/me", DonorController, :show_current
    get "/donors/email/:email_address", DonorController, :donor_by_email
    get "/donors/reset-password", DonorController, :send_reset_email
    put "/verify-accounts", DonorController, :verify_email
    put "/reset-passwords", DonorController, :send_reset_email

    put "/donors/reset-passwords", DonorController, :reset_donor_password

    resources "/donors", DonorController, except: [:new, :edit]


    resources "/payments", PaymentController, except: [:new, :edit]
    resources "/payment-methods", PaymentMethodController, except: [:new, :edit]
    resources "/addresses", AddressController, except: [:new, :edit]
    resources "/ongoing-donations", OngoingDonationController, except: [:new, :edit]
    resources "/campaigns", Api.CampaignController, except: [:new, :edit]
    resources "/organizations", OrganizationController, except: [:new, :edit]
    resources "/donor-organization-relationships", DonorOrganizationRelationshipController, except: [:new, :edit]
    resources "/vault-cards", VaultCardController, except: [:new, :edit]

    post "/session", SessionController, :create

    get "/payments/:payment_id/donor-organization-relationship", DonorOrganizationRelationshipController, :relationship_for_payment
    get "/payments/:payment_id/campaign", Api.CampaignController, :campaign_for_payment
    get "/payments/:payment_id/receipt", Api.ReceiptController, :get_receipt_for_payment

    get "/vaults/:vault_id/vault_cards", VaultCardController, :vault_cards_for_vault

    get "/donors/:donor_id/addresses", AddressController, :addresses_for_donor
    get "/donors/:donor_id/payment-methods", PaymentMethodController, :payment_methods_for_donor
    get "/donors/:donor_id/ongoing-donations", OngoingDonationController, :ongoing_donations_for_donor
    get "/donors/:donor_id/payments", PaymentController, :payments_for_donor
    get "/donors/:donor_id/vaults", VaultController, :vaults_for_donor
    get "/donors/:donor_id/vault-cards", VaultCardController, :vault_cards_for_donor

    get "/ongoing-donations/:ongoing_donation_id/donor", DonorController, :donor_for_ongoing_donation
    get "/ongoing-donations/:ongoing_donation_id/payment-method", PaymentMethodController, :payment_method_for_ongoing_donation
    get "/ongoing-donations/:ongoing_donation_id/campaign", Api.CampaignController, :campaign_for_ongoing_donation
    get "/ongoing-donations/:ongoing_donation_id/donor-organization-relationship", DonorOrganizationRelationshipController, :relationship_for_ongoing_donation

    get "/ongoing-donations/:ongoing_donation_id/vault-card", VaultCardController, :vault_card_for_ongoing_donation

    get "/addresses/:address_id/donor", DonorController, :donor_for_address
    get "/payment-methods/:payment_method_id/donor", DonorController, :donor_for_payment_method

    get "/campaigns/:campaign_id/organization", OrganizationController, :get_organization_for_campaign
    get "/organizations/:organization_id/campaigns", Api.CampaignController, :campaigns_for_organization

    get "/donor-organization-relationships/:relationship_id/donor", DonorController, :get_donor_for_relationship
    get "/donor-organization-relationships/:relationship_id/organization", OrganizationController, :get_organization_for_relationship
    get "/donor-organization-relationships/:relationship_id/ongoing-donations", OngoingDonationController, :ongoing_donations_for_relationship
    get "/donor-organization-relationships/:relationship_id/payments", PaymentController, :payments_for_ongoing_relationship
  end
end
