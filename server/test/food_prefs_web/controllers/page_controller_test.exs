defmodule FoodPrefsWeb.PageControllerTest do
  use FoodPrefsWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Czego nie je Piotrek"
  end
end
