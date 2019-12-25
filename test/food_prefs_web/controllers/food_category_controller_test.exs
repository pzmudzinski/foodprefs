defmodule FoodPrefsWeb.FoodCategoryControllerTest do
  use FoodPrefsWeb.ConnCase

  alias FoodPrefs.Food

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:food_category) do
    {:ok, food_category} = Food.create_food_category(@create_attrs)
    food_category
  end

  @tag :skip
  describe "index" do
    test "lists all categories", %{conn: conn} do
      conn = get(conn, Routes.food_category_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Categories"
    end
  end

  @tag :skip
  describe "new food_category" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.food_category_path(conn, :new))
      assert html_response(conn, 200) =~ "New Food category"
    end
  end

  @tag :skip
  describe "create food_category" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.food_category_path(conn, :create), food_category: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.food_category_path(conn, :show, id)

      conn = get(conn, Routes.food_category_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Food category"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.food_category_path(conn, :create), food_category: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Food category"
    end
  end

  @tag :skip
  describe "edit food_category" do
    setup [:create_food_category]

    test "renders form for editing chosen food_category", %{conn: conn, food_category: food_category} do
      conn = get(conn, Routes.food_category_path(conn, :edit, food_category))
      assert html_response(conn, 200) =~ "Edit Food category"
    end
  end

  @tag :skip
  describe "update food_category" do
    setup [:create_food_category]

    test "redirects when data is valid", %{conn: conn, food_category: food_category} do
      conn = put(conn, Routes.food_category_path(conn, :update, food_category), food_category: @update_attrs)
      assert redirected_to(conn) == Routes.food_category_path(conn, :show, food_category)

      conn = get(conn, Routes.food_category_path(conn, :show, food_category))
      assert html_response(conn, 200)
    end
    @tag :skip
    test "renders errors when data is invalid", %{conn: conn, food_category: food_category} do
      conn = put(conn, Routes.food_category_path(conn, :update, food_category), food_category: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Food category"
    end
  end

  @tag :skip
  describe "delete food_category" do
    setup [:create_food_category]

    test "deletes chosen food_category", %{conn: conn, food_category: food_category} do
      conn = delete(conn, Routes.food_category_path(conn, :delete, food_category))
      assert redirected_to(conn) == Routes.food_category_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.food_category_path(conn, :show, food_category))
      end
    end
  end

  defp create_food_category(_) do
    food_category = fixture(:food_category)
    {:ok, food_category: food_category}
  end
end
