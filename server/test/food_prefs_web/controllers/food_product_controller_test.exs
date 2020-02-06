defmodule FoodPrefsWeb.FoodProductControllerTest do
  use FoodPrefsWeb.ConnCase

  alias FoodPrefs.FoodPrefsWeb

  @create_attrs %{kcal: 42, name: "some name", notes: "some notes", score: 42}
  @update_attrs %{kcal: 43, name: "some updated name", notes: "some updated notes", score: 43}
  @invalid_attrs %{kcal: nil, name: nil, notes: nil, score: nil}

  def fixture(:food_product) do
    {:ok, food_product} = FoodPrefsWeb.create_food_product(@create_attrs)
    food_product
  end

  describe "index" do
    test "lists all food_products", %{conn: conn} do
      conn = get conn, Routes.food_product_path(conn, :index)
      assert html_response(conn, 200) =~ "Food products"
    end
  end

  describe "new food_product" do
    test "renders form", %{conn: conn} do
      conn = get conn, Routes.food_product_path(conn, :new)
      assert html_response(conn, 200) =~ "New Food product"
    end
  end

  describe "create food_product" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, Routes.food_product_path(conn, :create), food_product: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.food_product_path(conn, :show, id)

      conn = get conn, Routes.food_product_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Food product Details"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, Routes.food_product_path(conn, :create), food_product: @invalid_attrs
      assert html_response(conn, 200) =~ "New Food product"
    end
  end

  describe "edit food_product" do
    setup [:create_food_product]

    test "renders form for editing chosen food_product", %{conn: conn, food_product: food_product} do
      conn = get conn, Routes.food_product_path(conn, :edit, food_product)
      assert html_response(conn, 200) =~ "Edit Food product"
    end
  end

  describe "update food_product" do
    setup [:create_food_product]

    test "redirects when data is valid", %{conn: conn, food_product: food_product} do
      conn = put conn, Routes.food_product_path(conn, :update, food_product), food_product: @update_attrs
      assert redirected_to(conn) == Routes.food_product_path(conn, :show, food_product)

      conn = get conn, Routes.food_product_path(conn, :show, food_product)
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, food_product: food_product} do
      conn = put conn, Routes.food_product_path(conn, :update, food_product), food_product: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Food product"
    end
  end

  describe "delete food_product" do
    setup [:create_food_product]

    test "deletes chosen food_product", %{conn: conn, food_product: food_product} do
      conn = delete conn, Routes.food_product_path(conn, :delete, food_product)
      assert redirected_to(conn) == Routes.food_product_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, Routes.food_product_path(conn, :show, food_product)
      end
    end
  end

  defp create_food_product(_) do
    food_product = fixture(:food_product)
    {:ok, food_product: food_product}
  end
end
