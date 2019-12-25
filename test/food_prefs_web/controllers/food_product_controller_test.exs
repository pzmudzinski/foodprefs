defmodule FoodPrefsWeb.FoodProductControllerTest do
  use FoodPrefsWeb.ConnCase

  alias FoodPrefs.Food

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:food_product) do
    {:ok, food_product} = Food.create_food_product(@create_attrs)
    food_product
  end

  @tag :skip
  describe "index" do
    test "lists all products", %{conn: conn} do
      conn = get(conn, Routes.food_product_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Products"
    end
  end

  @tag :skip
  describe "new food_product" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.food_product_path(conn, :new))
      assert html_response(conn, 200) =~ "New Food product"
    end
  end

  @tag :skip
  describe "create food_product" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.food_product_path(conn, :create), food_product: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.food_product_path(conn, :show, id)

      conn = get(conn, Routes.food_product_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Food product"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.food_product_path(conn, :create), food_product: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Food product"
    end
  end

  @tag :skip
  describe "edit food_product" do
    setup [:create_food_product]

    test "renders form for editing chosen food_product", %{conn: conn, food_product: food_product} do
      conn = get(conn, Routes.food_product_path(conn, :edit, food_product))
      assert html_response(conn, 200) =~ "Edit Food product"
    end
  end

  @tag :skip
  describe "update food_product" do
    setup [:create_food_product]

    test "redirects when data is valid", %{conn: conn, food_product: food_product} do
      conn = put(conn, Routes.food_product_path(conn, :update, food_product), food_product: @update_attrs)
      assert redirected_to(conn) == Routes.food_product_path(conn, :show, food_product)

      conn = get(conn, Routes.food_product_path(conn, :show, food_product))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, food_product: food_product} do
      conn = put(conn, Routes.food_product_path(conn, :update, food_product), food_product: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Food product"
    end
  end

  @tag :skip
  describe "delete food_product" do
    setup [:create_food_product]

    test "deletes chosen food_product", %{conn: conn, food_product: food_product} do
      conn = delete(conn, Routes.food_product_path(conn, :delete, food_product))
      assert redirected_to(conn) == Routes.food_product_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.food_product_path(conn, :show, food_product))
      end
    end
  end

  defp create_food_product(_) do
    food_product = fixture(:food_product)
    {:ok, food_product: food_product}
  end
end
