defmodule DavosCharityApiWeb.AddressController do
  use DavosCharityApiWeb, :controller

  alias DavosCharityApi.Donor

  def addresses_for_donor(conn, %{"donor_id" => donor_id}) do
    addresses = Donor.list_addresses_for_donor(donor_id)
    render(conn, "index.json-api", data: addresses)
  end
end
