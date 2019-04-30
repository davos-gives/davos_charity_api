defmodule DavosCharityApiWeb.VaultCardView do
  use DavosCharityApiWeb, :view
  use JaSerializer.PhoenixView

  location "/api/vault-cards/:id"
  attributes [:iats_id, :name, :card_type, :last_four_digits, :primary]
end
