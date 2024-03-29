# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :davos_charity_api,
  ecto_repos: [DavosCharityApi.Repo],
  jwt_secret: System.get_env("JWT_SECRET") || "gjAjSF8cOSxzqEjoNYC6I9flgUJdHJPrPx7hnzEcQCBVCDaLCrY8G/AN6fmewFF/"

# Configures the endpoint
config :davos_charity_api, DavosCharityApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "WUIVtXmdSHXNGgEpt/6JvEtkSKtnYG6cAt50rriweqR4WT0VV22QzwjYAPpItEoj",
  render_errors: [view: DavosCharityApiWeb.ErrorView, accepts: ~w(html json json-api)],
  pubsub: [name: DavosCharityApi.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :mime, :types, %{
  "application/vnd.api+json" => ["json-api"],
  "application/json" => ["json"]
}

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :phoenix, :format_encoders, "json-api": Jason
config :phoenix, :format_encoders, "json": Jason

config :ja_serializer, pluralize_types: true

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
