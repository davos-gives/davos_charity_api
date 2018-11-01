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
  end

  scope "/", DavosCharityApiWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/api", DavosCharityApiWeb do
    pipe_through :api

    resources "/donors", DonorController, except: [:new, :edit]
    resources "/payment-methods", PaymentMethodController, except: [:new, :edit]
    resources "/addresses", AddressController, except: [:new, :edit]

    get "/donors/:donor_id/addresses", AddressController, :addresses_for_donor
    get "/donors/:donor_id/payment-methods", PaymentMethodController, :payment_methods_for_donor
  end
end
