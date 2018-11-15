defmodule DavosCharityApiWeb.SessionView do
  use DavosCharityApiWeb, :view

  def render("token.json", donor) do
    data = %{id: donor.id, email: donor.email}

    jwt = %{data: data, sub: donor.id}
    |> Joken.token
    |> Joken.with_signer(Joken.hs512(Application.get_env(:davos_charity_api, :jwt_secret)))
    |> Joken.sign

    %{token: jwt.token}
  end
end
