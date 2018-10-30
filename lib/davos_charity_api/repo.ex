defmodule DavosCharityApi.Repo do
  use Ecto.Repo,
    otp_app: :davos_charity_api,
    adapter: Ecto.Adapters.Postgres
end
