defmodule DavosCharityApiWeb.DonorControllerTest do
  use DavosCharityApiWeb.ConnCase

  require IEx


  setup %{conn: conn} do
    conn =
      conn
      |> put_req_header("accept", "application/vnd.api+json")
      |> put_req_header("content-type", "application/vnd.api+json")

    {:ok, conn: conn}
  end

  # test "lists all donors on index", %{conn: conn} do
  #   donor = donor_fixture()
  #
  #   response =
  #     conn
  #     |> get(Routes.donor_path(conn, :index))
  #     |> json_response(200)
  #
  #   expected = %{
  #     "data" => [%{
  #       "attributes" => %{
  #         "fname" => donor.fname,
  #         "lname" => donor.lname,
  #         "email" => donor.email
  #       },
  #       "links" => %{
  #         "self" => "/donors/#{donor.id}"
  #       },
  #       "id" => "#{donor.id}",
  #       "relationships" => %{
  #         "addresses" => %{
  #           "links" => %{
  #             "related" => "/donors/#{donor.id}/addresses"
  #           }
  #         },
  #         "payment-methods" => %{
  #           "links" => %{
  #             "related" => "/donors/#{donor.id}/payment-methods"
  #           }
  #         }
  #       },
  #       "type" => "donor"
  #     }
  #   ],
  #   "jsonapi" => %{
  #     "version" => "1.0"
  #   }
  #   }
  #
  #   assert response == expected
  # end
end
