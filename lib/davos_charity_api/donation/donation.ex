defmodule DavosCharityApi.Donation do

  alias DavosCharityApi.Repo
  alias DavosCharityApi.Donation.Ongoing

  def create_ongoing_gift(attrs \\ %{}) do
    %Ongoing{}
    |> Ongoing.changeset(attrs)
    |> Repo.insert
  end
end
