defmodule DavosCharityApi.TestHelpers do

  alias DavosCharityApi.{
    Donor,
    Organization,
    Donor.PaymentMethod,
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

  def payment_option_fixture(attrs \\ %{}) do
    {:ok, paymentMethod} =
      attrs
      |> Enum.into(%{
        name: "Vancity Visa",
        type: "visa",
        number: "4545454545454545",
        expiry: "01/21",
        cvv: 123,
      })
      |> Donor.create_payment_method()
    paymentMethod
  end
end
