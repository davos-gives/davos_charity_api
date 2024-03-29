defmodule DavosCharityApi.Organization.Management do

  import Ecto.Changeset
  import Ecto.Query

  alias DavosCharityApi.Repo

  alias DavosCharityApi.Organization
  alias DavosCharityApi.Organization.{User, Management, Comment}

  import IEx

  def get_user_by_email!(email), do: Repo.get_by!(User, email: email)

  def get_user!(id) do
    user = Repo.get!(User, id)
    user = Repo.preload(user, [:organization])
  end

  def get_comment!(id), do: Repo.get!(Comment, id)

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

  def get_user_for_comment(comment_id) do
    comment = Management.get_comment!(comment_id)
    comment = Repo.preload(comment, :user)
    comment.user
  end

  def create_comment(attrs) do
    %Comment{}
    |> Comment.changeset(attrs)
    |> Repo.insert
  end
end
