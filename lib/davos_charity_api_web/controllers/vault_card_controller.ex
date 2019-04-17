defmodule DavosCharityApiWeb.VaultCardController do
  use DavosCharityApiWeb, :controller

  alias DavosCharityApi.Fundraising
  alias DavosCharityApi.Fundraising.Campaign
  alias DavosCharityApi.Donor

  alias IEx

  def vault_cards_for_vault(conn, %{"vault_id" => vault_id}) do
    vault_cards = Donor.get_cards_for_vault(vault_id)
    render(conn, "show.json-api", data: vault_cards)
  end
end
