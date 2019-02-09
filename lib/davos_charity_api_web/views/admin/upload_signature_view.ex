defmodule DavosCharityApiWeb.Admin.UploadSignatureView do
  use DavosCharityApiWeb, :view

  def render("create.json", %{signature: signature}) do
    signature
  end

end
