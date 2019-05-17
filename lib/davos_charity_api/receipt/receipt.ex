defmodule DavosCharityApi.Receipt do
  use Ecto.Schema
  use Export.Python

  import Ecto.Query
  import Ecto.Changeset
  alias Ecto.Multi

  alias DavosCharityApi.Repo

  alias DavosCharityApi.Receipt
  alias DavosCharityApi.Receipt.ReceiptStack
  alias DavosCharityApi.Donation.Payment
  alias DavosCharityApi.Donor
  alias DavosCharityApi.Donation

  import IEx

  schema "receipts" do
    field :charitable_registration_number, :string
    field :receipt_number, :integer
    field :payment_date, :date
    field :payment_amount, :integer
    field :fname, :string
    field :lname, :string
    field :address_1, :string
    field :address_2, :string
    field :postal_code, :string
    field :country, :string
    field :province, :string
    field :city, :string
    field :advantage_value, :integer
    field :amount_eligable_for_tax_purposes, :integer
    field :url, :string
    belongs_to :payment, Payment
    belongs_to :donor, Donor

    timestamps()
  end

  def changeset(receipt, attrs) do
    receipt
    |> cast(attrs, [:charitable_registration_number, :payment_amount, :receipt_number, :payment_date, :fname, :lname, :address_1, :address_2, :postal_code, :country, :province, :city, :advantage_value, :amount_eligable_for_tax_purposes, :donor_id, :url, :payment_id])
    |> validate_required( [:charitable_registration_number, :receipt_number, :fname, :lname, :address_1, :postal_code, :country, :province, :city, :advantage_value, :amount_eligable_for_tax_purposes, :payment_amount, :donor_id, :payment_id])
  end

  def create_receipt_and_update_stack(attrs \\ %{}) do
    Multi.new()
    |> create_receipt!(attrs)
    |> update_receipt_stack(attrs)
    |> Repo.transaction
  end

  defp create_receipt!(multi, attrs \\ %{}) do
    Multi.run(multi, :created_receipt, fn repo, %{} ->
      receipt_number = Receipt.get_receipt_stack!(1).current_receipt_number + 1

      attrs = attrs
      |> Map.put("receipt_number", receipt_number)
      |> Map.put("url", "https://davos-assets.sfo2.cdn.digitaloceanspaces.com/receipts/#{receipt_number}.pdf")

      new_receipt = %Receipt{}
      |> Receipt.changeset(attrs)
      |> Repo.insert
    end)
  end

  def create_receipt_stack(attrs \\ %{}) do
    %ReceiptStack{}
    |> ReceiptStack.changeset(attrs)
    |> Repo.insert
  end

  def get_receipt_stack!(id) do
    ReceiptStack
    |> Repo.get!(id)
  end

  def get_receipt!(id) do
    Receipt
    |> Repo.get!(id)
  end

  def list_receipts(), do: Repo.all(Receipt)

  def search_receipts(search_term) do
    search_term = String.downcase(search_term)

    Receipt
    |> where([a], like(fragment("lower(?)", a.fname), ^"%#{search_term}%"))
    |> or_where([a], like(fragment("lower(?)", a.lname), ^"%#{search_term}%"))
    |> or_where([a], a.receipt_number == ^search_term)
    |> or_where([a], a.payment_amount == ^search_term * 100)
    |> order_by(desc: :inserted_at)
    |> Repo.all
  end


  def get_receipt_for_payment!(id) do
    payment = Donation.get_payment!(id)
    payment = Repo.preload(payment, :receipts)
    payment.receipts
  end

  defp update_receipt_stack(multi, attrs \\ %{}) do
    Multi.run(multi, :updated_stack, fn repo, %{created_receipt: created_receipt} ->

      attrs = %{current_receipt_number: created_receipt.receipt_number}

      Receipt.get_receipt_stack!(1)
      |> ReceiptStack.changeset(attrs)
      |> Repo.update
    end)

  end

  # BUILD ZE PDF

  def build_receipt_pdf(id) do
    {:ok, py} = Python.start(python_path: Path.expand("lib/python"))

    py |> Python.call(build(id), from_file: "receipt")
  end
end
