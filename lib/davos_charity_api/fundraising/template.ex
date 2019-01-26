defmodule DavosCharityApi.Fundraising.Template do
  use Ecto.Schema
  import Ecto.Changeset

  alias DavosCharityApi.Fundraising.Template

  schema "templates" do
    field :name, :string
    field :description, :string
    field :goal, :integer
    field :end_date, :string
    field :go_back_url, :string
    field :font, :string
    field :size, :string
    field :colour, :string
    timestamps()
  end

  def changeset(%Template{} = model, attrs) do
    model
    |> cast(attrs, [:name, :description, :goal, :end_date, :go_back_url, :font, :size, :colour])
    |> validate_required([:name, :description])
  end
end
