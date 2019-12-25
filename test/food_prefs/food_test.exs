defmodule FoodPrefs.FoodTest do
  use FoodPrefs.DataCase

  alias FoodPrefs.Food


  defp hook_create_category(context) do
    {:ok, category} = Food.create_food_category(%{ name: "My Category" })
    [category: category]
  end

  describe "products" do
    setup [:hook_create_category]
    alias FoodPrefs.FoodProduct

    @valid_attrs %{ name: "My Food Product" }
    @update_attrs %{ name: "My Updated Food Product" }
    @invalid_attrs %{ name: nil }

    def food_product_fixture(attrs \\ %{}) do
      {:ok, food_product} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Food.create_food_product()

      food_product
    end

    @tag :list_categories_with_top_products
    test "list_categories_with_top_products", %{category: category} do
      food_product = food_product_fixture(%{category_id: category.id})
      IO.inspect Food.list_categories_with_top_product(10)
    end

    test "list_products/0 returns all products", %{category: category} do
      food_product = food_product_fixture(%{category_id: category.id})
      assert Food.list_products() == [food_product]
    end

    test "get_food_product!/1 returns the food_product with given id", %{category: category} do
      food_product = food_product_fixture(%{category_id: category.id})
      assert Food.get_food_product!(food_product.id) == food_product
    end


    test "create_food_product/1 with valid data creates a food_product", %{category: category} do
      assert {:ok, %FoodProduct{} = food_product} = Food.create_food_product(Map.merge(@valid_attrs, %{category_id: category.id}))
    end

    test "create_food_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Food.create_food_product(@invalid_attrs)
    end

    test "update_food_product/2 with valid data updates the food_product", %{category: category}  do
      food_product = food_product_fixture(%{category_id: category.id})
      assert {:ok, %FoodProduct{} = food_product} = Food.update_food_product(food_product, @update_attrs)
    end

    test "update_food_product/2 with invalid data returns error changeset", %{category: category} do
      food_product = food_product_fixture(%{category_id: category.id})
      assert {:error, %Ecto.Changeset{}} = Food.update_food_product(food_product, @invalid_attrs)
      assert food_product == Food.get_food_product!(food_product.id)
    end

    test "delete_food_product/1 deletes the food_product", %{category: category} do
      food_product = food_product_fixture(%{category_id: category.id})
      assert {:ok, %FoodProduct{}} = Food.delete_food_product(food_product)
      assert_raise Ecto.NoResultsError, fn -> Food.get_food_product!(food_product.id) end
    end

    test "change_food_product/1 returns a food_product changeset", %{category: category} do
      food_product = food_product_fixture(%{category_id: category.id})
      assert %Ecto.Changeset{} = Food.change_food_product(food_product)
    end
  end

  describe "categories" do
    alias FoodPrefs.FoodCategory

    @valid_attrs %{ name: "My Food Category" }
    @update_attrs %{ name: "Updated name" }
    @invalid_attrs %{ name: nil }

    def food_category_fixture(attrs \\ %{}) do
      {:ok, food_category} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Food.create_food_category()

      food_category
    end

    test "list_categories/0 returns all categories" do
      food_category = food_category_fixture()
      assert Food.list_categories() == [food_category]
    end

    test "get_food_category!/1 returns the food_category with given id" do
      food_category = food_category_fixture()
      assert Food.get_food_category!(food_category.id) == food_category
    end

    @tag :wip
    test "create_food_category/1 with valid data creates a food_category" do
      assert {:ok, %FoodCategory{} = food_category} = Food.create_food_category(@valid_attrs)
    end

    test "create_food_category/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Food.create_food_category(@invalid_attrs)
    end

    test "update_food_category/2 with valid data updates the food_category" do
      food_category = food_category_fixture()
      assert {:ok, %FoodCategory{} = food_category} = Food.update_food_category(food_category, @update_attrs)
    end

    test "update_food_category/2 with invalid data returns error changeset" do
      food_category = food_category_fixture()
      assert {:error, %Ecto.Changeset{}} = Food.update_food_category(food_category, @invalid_attrs)
      assert food_category == Food.get_food_category!(food_category.id)
    end

    test "delete_food_category/1 deletes the food_category" do
      food_category = food_category_fixture()
      assert {:ok, %FoodCategory{}} = Food.delete_food_category(food_category)
      assert_raise Ecto.NoResultsError, fn -> Food.get_food_category!(food_category.id) end
    end

    test "change_food_category/1 returns a food_category changeset" do
      food_category = food_category_fixture()
      assert %Ecto.Changeset{} = Food.change_food_category(food_category)
    end
  end
end
