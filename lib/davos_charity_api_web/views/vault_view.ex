defmodule DavosCharityApiWeb.VaultView do
  use DavosCharityApiWeb, :view
  use JaSerializer.PhoenixView

  location "/api/vaults/:id"
  attributes [:iats_id]
end
