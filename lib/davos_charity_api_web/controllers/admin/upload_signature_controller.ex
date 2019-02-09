defmodule DavosCharityApiWeb.Admin.UploadSignatureController do
  use DavosCharityApiWeb, :controller

  require IEx

  def create(conn, %{"filename" => filename, "mimetype" => mimetype}) do
    conn
    |> put_status(:created)
    |> render("create.json", signature: sign(filename , mimetype))
  end


  defp sign(filename, mimetype) do
    policy = policy(filename, mimetype)

    %{
      key: filename,
      'Content-Type': mimetype,
      acl: "public-read",
      success_action_status: "201",
      action: "https://davos-assets.sfo2.digitaloceanspaces.com",
      'AWSAccessKeyId': "JGNPQC2ZYPTPLNDUXJFK",
      policy: policy,
      signature: hmac_sha1("Qv1/AwUfyYc2cZZxqUSpUObYm9e2G8ouIJUk0bD2Dk8", policy)
    }
  end

  defp now_plus(minutes) do
    import Timex
    now
    |> shift(minutes: minutes)
    |> format!("{ISO:Extended:Z}")
  end

  defp hmac_sha1(secret, msg) do
    :crypto.hmac(:sha, secret, msg)
    |> Base.encode64
  end

  defp policy(key, mimetype, expiration_window \\ 60) do
    %{
      # This policy is valid for an hour by default.
      expiration: now_plus(expiration_window),
      conditions: [
        # You can only upload to the bucket we specify.
        %{bucket: "davos-assets"},
        %{action: "https://davos-assets.sfo2.digitaloceanspaces.com"},
        # The uploaded file must be publicly readable.
        %{acl: "public-read"},
        # You have to upload the mime type you said you would upload.
        ["starts-with", "$Content-Type", mimetype],
        # You have to upload the file name you said you would upload.
        ["starts-with", "$key", key],
        # When things work out ok, AWS should send a 201 response.
        %{success_action_status: "201"},
      ]
    }
    # Let's make this into JSON.
    |> Jason.encode!
    # We also need to base64 encode it.
    |> Base.encode64
  end
end
