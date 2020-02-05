defmodule FoodPrefs.FoodPrefsWebTest do
  use FoodPrefs.DataCase

  alias FoodPrefs.FoodPrefsWeb

  describe "food_categories" do
    alias FoodPrefs.FoodPrefsWeb.FoodCategory

    @valid_attrs %{name: "some name", notes: "some notes"}
    @update_attrs %{name: "some updated name", notes: "some updated notes"}
    @invalid_attrs %{name: nil, notes: nil}

    def food_category_fixture(attrs \\ %{}) do
      {:ok, food_category} =
        attrs
        |> Enum.into(@valid_attrs)
        |> FoodPrefsWeb.create_food_category()

      food_category
    end

    test "paginate_food_categories/1 returns paginated list of food_categories" do
      for _ <- 1..20 do
        food_category_fixture()
      end

      {:ok, %{food_categories: food_categories} = page} = FoodPrefsWeb.paginate_food_categories(%{})

      assert length(food_categories) == 15
      assert page.page_number == 1
      assert page.page_size == 15
      assert page.total_pages == 2
      assert page.total_entries == 20
      assert page.distance == 5
      assert page.sort_field == "inserted_at"
      assert page.sort_direction == "desc"
    end

    test "list_food_categories/0 returns all food_categories" do
      food_category = food_category_fixture()
      assert FoodPrefsWeb.list_food_categories() == [food_category]
    end

    test "get_food_category!/1 returns the food_category with given id" do
      food_category = food_category_fixture()
      assert FoodPrefsWeb.get_food_category!(food_category.id) == food_category
    end

    test "create_food_category/1 with valid data creates a food_category" do
      assert {:ok, %FoodCategory{} = food_category} = FoodPrefsWeb.create_food_category(@valid_attrs)
      assert food_category.name == "some name"
      assert food_category.notes == "some notes"
    end

    test "create_food_category/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = FoodPrefsWeb.create_food_category(@invalid_attrs)
    end

    test "update_food_category/2 with valid data updates the food_category" do
      food_category = food_category_fixture()
      assert {:ok, food_category} = FoodPrefsWeb.update_food_category(food_category, @update_attrs)
      assert %FoodCategory{} = food_category
      assert food_category.name == "some updated name"
      assert food_category.notes == "some updated notes"
    end

    test "update_food_category/2 with invalid data returns error changeset" do
      food_category = food_category_fixture()
      assert {:error, %Ecto.Changeset{}} = FoodPrefsWeb.update_food_category(food_category, @invalid_attrs)
      assert food_category == FoodPrefsWeb.get_food_category!(food_category.id)
    end

    test "delete_food_category/1 deletes the food_category" do
      food_category = food_category_fixture()
      assert {:ok, %FoodCategory{}} = FoodPrefsWeb.delete_food_category(food_category)
      assert_raise Ecto.NoResultsError, fn -> FoodPrefsWeb.get_food_category!(food_category.id) end
    end

    test "change_food_category/1 returns a food_category changeset" do
      food_category = food_category_fixture()
      assert %Ecto.Changeset{} = FoodPrefsWeb.change_food_category(food_category)
    end
  end
end
