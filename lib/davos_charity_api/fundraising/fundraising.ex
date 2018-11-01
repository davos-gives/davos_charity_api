defmodule DavosCharityApi.Fundraising do
  use Ecto.Schema

  alias DavosCharityApi.Repo
  alias DavosCharityApi.Fundraising.Form

  import Ecto.Query

  def create_form(attrs \\ %{}) do
    %Form{}
    |> Form.changeset(attrs)
    |> Repo.insert
  end

  def get_form!(id), do: Repo.get!(Form, id)

end
