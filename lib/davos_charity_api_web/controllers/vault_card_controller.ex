defmodule DavosCharityApiWeb.VaultCardController do
  use DavosCharityApiWeb, :controller

  alias DavosCharityApi.Fundraising
  alias DavosCharityApi.Fundraising.Campaign
  alias DavosCharityApi.Donor
  alias DavosCharityApi.Donor.VaultCard

  import IEx

  plug :authenticate_donor when action in [:show, :create]


  def vault_cards_for_vault(conn, %{"vault_id" => vault_id}) do
    vault_cards = Donor.get_cards_for_vault(vault_id)
    render(conn, "show.json-api", data: vault_cards)
  end

  def vault_cards_for_donor(conn, %{"donor_id" => donor_id}) do
    vault_cards = Donor.list_cards_for_donor(donor_id)
    render(conn, "show.json-api", data: vault_cards)
  end

  def create(conn, %{:current_donor => current_donor, "data" => data = %{"type" => "vault-cards", "attributes" => _params}}) do
    data = data
    |> JaSerializer.Params.to_attributes()
    |> Map.put("donor_id", current_donor.id)

    case Donor.add_credit_card_to_vault(data) do
      {:ok, %{final: {:ok, %VaultCard{} = vault_card}}} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", Routes.vault_card_path(conn, :show, vault_card))
        |> render("show.json-api", data: vault_card)
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:bad_request)
        |> render(DavosCharityApiWeb.ErrorView, "400,json-api", changeset)
    end
  end
end
