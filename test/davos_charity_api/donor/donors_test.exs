defmodule DavosCharityApi.DonorsTest do
  use DavosCharityApi.DataCase

  alias DavosCharityApi.Donor
  alias DavosCharityApi.Donor.{
    PaymentMethod,
    Address
  }
  alias DavosCharityApi.Donation
  alias DavosCharityApi.Donation.{
    Ongoing,
    Payment
  }

  require IEx

  describe "create_donor/1" do
    @valid_attrs %{
      email: "ian.knauer@davos.gives",
      fname: "ian",
      lname: "knauer"
    }

    @invalid_attrs %{}

    test "with valid data inserts the donor" do
      assert {:ok, %Donor{id: id} = donor} = Donor.create_donor(@valid_attrs)
      assert donor.fname == "ian"
      assert donor.lname == "knauer"
      assert donor.email == "ian.knauer@davos.gives"
      assert [%Donor{id: ^id}] = Donor.list_donors()
    end

    test "with invalid data does not insert the donor" do
      assert {:error, _changeset} = Donor.create_donor(@invalid_attrs)
      assert Donor.list_donors == []
    end
  end

  describe "create_payment_method/1" do
    @valid_attrs %{
      name: "visa",
      type: "visa",
      number: "4545454545454545",
      expiry: "01/21",
      cvv: 123,
    }

    @invalid_attrs %{}

    test "with valid data inserts payment method" do
      donor = donor_fixture()

      assert {:ok, paymentMethod} = Donor.create_payment_method(Map.put(@valid_attrs, :donor_id, donor.id))
      assert paymentMethod.name == "visa"
      assert paymentMethod.type =="visa"
      assert paymentMethod.number == "4545454545454545"
      assert paymentMethod.expiry == "01/21"
      assert paymentMethod.cvv == 123
    end

    test "with valid data attaches payment method to donor" do
      donor = donor_fixture()

      {:ok, %PaymentMethod{id: id} = paymentMethod} = Donor.create_payment_method(Map.put(@valid_attrs, :donor_id, donor.id))

      assert [%PaymentMethod{id: id}] = Donor.list_payment_methods_for_donor(donor.id)
    end

    test "with invalid data does not insert the payment method" do
      donor = donor_fixture()

      assert {:error, _changeset} = Donor.create_address(@invalid_attrs)
      assert Donor.list_payment_methods_for_donor(donor.id) == []
    end
  end

  describe "create_address/1" do
    @valid_attrs %{
      name: "Home",
      address_1: "123 Fake Street",
      postal_code: "a1b 2c3",
      city: "Vancouver",
      province: "BC",
      country: "Canada"
    }


    test "with valid data inserts address and attaches it to donor" do
      donor = donor_fixture()

      {:ok, %Address{id: id} = address} = Donor.create_address(Map.put(@valid_attrs, :donor_id, donor.id))

      assert address.name == "Home"
      assert address.address_1 == "123 Fake Street"
      assert address.postal_code == "a1b 2c3"
      assert address.city == "Vancouver"
      assert address.province == "BC"
      assert address.country == "Canada"

      assert [%Address{id: id}] = Donor.list_addresses_for_donor(donor.id)
    end

    test "with invalid data does not insert the address" do
      donor = donor_fixture()

      assert {error, _changeset} = Donor.create_address(@invalid_attrs)
      assert Donor.list_addresses_for_donor(donor.id) == []
    end
  end

  describe "create_ongoing_gift_for_donor/1" do
    @valid_attrs %{
      frequency: "Daily",
      status: "Active",
      amount: 125,
    }

    test "with valid data inserts ongoing donation and attaches it to donor" do
      donor = donor_fixture()

      {:ok, %Ongoing{id: id} = ongoing_donation} = Donation.create_ongoing_gift(Map.put(@valid_attrs, :donor_id, donor.id))

      assert ongoing_donation.frequency == "Daily"
      assert ongoing_donation.status == "Active"
      assert ongoing_donation.amount == 125

      assert [%Ongoing{id: id}] = Donor.list_ongoing_donations_for_donor(donor.id)
    end
  end
end
