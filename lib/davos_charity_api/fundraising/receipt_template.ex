defmodule DavosCharityApi.Fundraising.ReceiptTemplate do
  use Ecto.Schema
  import Ecto.Changeset

    alias DavosCharityApi.Fundraising.ReceiptTemplate

  schema "receipt_templates" do
    field :logo, :string
    field :header, :string
    field :description, :string
    field :signature, :string
    field :font, :string
    field :primary_colour, :string
    field :secondary_colour, :string
    timestamps()
  end

  def changeset(%ReceiptTemplate{} = model, attrs) do
    model
    |> cast(attrs, [:logo, :header, :description, :signature, :font, :primary_colour, :secondary_colour])
    |> validate_required([:header, :description])
  end
end
