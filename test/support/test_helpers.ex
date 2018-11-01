defmodule DavosCharityApi.TestHelpers do

  alias DavosCharityApi.{
    Donor
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
end
