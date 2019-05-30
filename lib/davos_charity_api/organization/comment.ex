defmodule DavosCharityApi.Organization.Comment do
  use Ecto.Schema

  import Ecto.Changeset
  import Ecto.Query

  alias Comeonin.Bcrypt
  alias Ecto.Multi


  alias DavosCharityApi.Repo
  alias DavosCharityApi.Organization
  alias DavosCharityApi.Organization.{User, Comment}
  alias DavosCharityApi.Donor

  import Ecto.Query
  import Exiats
  import IEx

  schema "comments" do
    field :body, :string
    belongs_to :user, User
    belongs_to :donor, Donor
    timestamps()
  end

  def changeset(%Comment{} = model, attrs) do
    model
    |> cast(attrs, [:body, :donor_id, :user_id])
    |> validate_required([:body, :donor_id, :user_id])
  end
end
