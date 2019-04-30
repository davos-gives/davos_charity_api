defmodule DavosCharityApi.Donor.Token do

  alias DavosCharityApi.Donor

  @account_verification_salt "account verification salt"

  def generate_new_account_token(%Donor{id: donor_id}) do
    Phoenix.Token.sign(DavosCharityApiWeb.Endpoint, @account_verification_salt, donor_id)
  end

  def verify_new_account_token(token) do
    max_age = 86_400
    Phoenix.Token.verify(DavosCharityApiWeb.Endpoint, @account_verification_salt, token, max_age: max_age)
  end

  def verify_password_reset_token(token) do
    max_age = 86_400
    Phoenix.Token.verify(DavosCharityApiWeb.Endpoint, @account_verification_salt, token, max_age: max_age)
  end

end
