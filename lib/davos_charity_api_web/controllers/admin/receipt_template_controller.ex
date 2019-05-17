defmodule DavosCharityApiWeb.Admin.ReceiptTemplateController do
  use DavosCharityApiWeb, :controller

  alias DavosCharityApi.Fundraising
  alias DavosCharityApi.Fundraising.ReceiptTemplate

    def show(conn, %{"id" => id}) do
      receipt_template = Fundraising.get_receipt_template!(id)
      render(conn, "show.json-api", data: receipt_template)
    end

    def update(conn, %{"id" => id, "data" => data = %{"type" => "receipt-templates", "attributes" => _params}}) do
      data = JaSerializer.Params.to_attributes(data)
      receipt_template = Fundraising.get_receipt_template!(id)

      case Fundraising.update_receipt_template(receipt_template, data) do
        {:ok, %ReceiptTemplate{} = template} ->
          conn
          |> render("show.json-api", data: template)
        {:error, %Ecto.Changeset{} = changeset} ->
          conn
          |> put_status(:unprocessable_entity)
          |> render(DavosCharityApiWeb.ErrorView, "400.json-api", changeset)
      end
    end
end
