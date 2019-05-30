defmodule DavosCharityApi.Organization.Management do

  import Ecto.Changeset
  import Ecto.Query

  alias DavosCharityApi.Repo

  alias DavosCharityApi.Organization
  alias DavosCharityApi.Organization.User
  alias DavosCharityApi.Organization.Management

  def get_user_by_email!(email), do: Repo.get_by!(User, email: email)

  def get_user!(id) do

    user = Repo.get!(User, id)
    user = Repo.preload(user, [:organization])
  end

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert
  end

  def get_organization_for_user(user_id) do
    donor = Management.get_user!(user_id)
    donor = Repo.preload(donor, :organization)
    donor.organization
  end
end
