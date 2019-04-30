defmodule DavosCharityApi.Email do
  import Bamboo.Email
  import Bamboo.Phoenix

  import IEx

  def send_account_verification_email(donor, token) do
    new_email(
      to: donor.email,
      from: "info@davos.gives",
      subject: "Welcome to Davos! Please confirm your account",
      html_body: "Hey #{donor.fname} #{donor.lname},<br /><br /><strong>Thanks for creating an account with Davos!</strong> Please click on the <a href="<>"http://localhost:4200/verify-account?token=#{token}"<>" target=`_blank`>link here</a> to verify your email address and access your account.",
      text_body: "Thanks for joining! please click on the link here #{token}"
    )
  end

  def send_password_reset_email(donor, token) do
    new_email(
      to: donor.email,
      from: "info@davos.gives",
      subject: "Reset your Davos account password.",
      html_body: "Hey #{donor.fname} #{donor.lname},<br /><br /><strong>It looks like you've requested a link to reset your password.</strong> Please click on the <a href="<>"http://localhost:4200/password-reset?token=#{token}"<>" target=`_blank`>link here</a> to reset your password. This link will expire in 15 minuites.",
      text_body: ""
    )
  end

end
