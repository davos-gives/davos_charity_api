defmodule DavosCharityApiWeb.Admin.ExportController do
  use DavosCharityApiWeb, :controller

  alias DavosCharityApi.Donor
  alias DavosCharityApi.Donation

  import CSV
  import IEx

  def get_csv_for_export(conn, params = %{"id" => id}) do
    conn
    |> put_resp_content_type("text/csv")
    |> put_resp_header("content-disposition", "attachment; filename=\"${testing}.csv\"")
    |> send_resp(200, csv_content(params))
  end

  def get_csv_for_export(conn, params) do
    conn
    |> put_resp_content_type("text/csv")
    |> put_resp_header("content-disposition", "attachment; filename=\"${testing}.csv\"")
    |> send_resp(200, csv_content_no_ids(params))
  end

  defp csv_content(%{"id" => ids, "modelType" => type}) do
    list_of_ids = ids |> String.split(",") |> Enum.map(&String.to_integer/1)

    result = cond do
      type == "donors" ->
        [["id", "first name", "last name", "email"]]
        |> Stream.concat(Donor.find_donors_by_ids(list_of_ids) |> Stream.map(&[&1.id, &1.fname, &1.lname, &1.email]))
      type == "payments" ->
        [["id", "amount", "IATS reference number", "campaign id"]]
        |> Stream.concat(Donation.find_payments_by_ids(list_of_ids) |> Stream.map(&[&1.id, &1.amount / 100, &1.reference_number, &1.campaign_id]))
    end
    |> CSV.encode
    |> Enum.to_list
    |> to_string
  end

  defp csv_content_no_ids(%{"modelType" => type}) do
    result = cond do
      type == "donors" ->
        [["id", "first name", "last name", "email"]]
        |> Stream.concat(Donor.list_donors |> Stream.map(&[&1.id, &1.fname, &1.lname, &1.email]))
      type == "payments" ->
        [["id", "amount", "IATS reference number", "campaign id"]]
        |> Stream.concat(Donation.list_payments |> Stream.map(&[&1.id, &1.amount / 100, &1.reference_number, &1.campaign_id]))
    end
    |> CSV.encode
    |> Enum.to_list
    |> to_string
  end

  defp to_integer(value) do
    value
    |> Decimal.from_float()
    |> Decimal.mult(Decimal.new(100))
    |> Decimal.round(0)
    |> Decimal.to_integer()
  end


end
