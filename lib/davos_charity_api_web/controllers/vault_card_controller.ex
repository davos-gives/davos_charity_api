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

  def vault_cards_for_donor(conn, %{"donor_id" => donor_id}) do
    vault_cards = Donor.list_cards_for_donor(donor_id)
    render(conn, "show.json-api", data: vault_cards)
  end
end
