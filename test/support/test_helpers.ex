defmodule DavosCharityApi.TestHelpers do

  alias DavosCharityApi.{
    Donor,
    Organization
  }

  def donor_fixture(attrs \\ %{}) do
    unique_key = "donor-#{System.unique_integer([:positive])}"

    {:ok, donor} =
      attrs
      |> Enum.into(%{
          fname: "Johnny",
          lname: unique_key,
          email: "Johnny.#{unique_key}@davos.gives"
        })
      |> Donor.create_donor()

    donor
  end

  def organization_fixture(attrs \\ %{}) do
    unique_key = "organization-#{System.unique_integer([:positive])}"

    {:ok, organization} =
      attrs
      |> Enum.into(%{
          name: unique_key,
          logo: "/img/url.png",
        })
      |> Organization.create_organization()
    organization

  end
end
