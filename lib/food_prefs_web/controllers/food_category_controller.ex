defmodule FoodPrefsWeb.FoodCategoryController do
  use FoodPrefsWeb, :controller

  alias FoodPrefs.Food
  alias FoodPrefs.FoodCategory

  def index(conn, _params) do
    categories = Food.list_categories_with_top_product(10)
    IO.inspect(categories, limit: :infinity)
    render(conn, "index.html", categories: categories)
  end

  def new(conn, _params) do
    changeset = Food.change_food_category(%FoodCategory{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"food_category" => food_category_params}) do
    case Food.create_food_category(food_category_params) do
      {:ok, food_category} ->
        conn
        |> put_flash(:info, "Food category created successfully.")
        |> redirect(to: Routes.food_category_path(conn, :show, food_category))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    food_category = Food.get_food_category!(id)
    food_products = Food.list_products(id)
    render(conn, "show.html", food_category: food_category, food_products: food_products)
  end

  def edit(conn, %{"id" => id}) do
    food_category = Food.get_food_category!(id)
    changeset = Food.change_food_category(food_category)
    render(conn, "edit.html", food_category: food_category, changeset: changeset)
  end

  def update(conn, %{"id" => id, "food_category" => food_category_params}) do
    food_category = Food.get_food_category!(id)

    case Food.update_food_category(food_category, food_category_params) do
      {:ok, food_category} ->
        conn
        |> put_flash(:info, "Food category updated successfully.")
        |> redirect(to: Routes.food_category_path(conn, :show, food_category))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", food_category: food_category, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    food_category = Food.get_food_category!(id)
    {:ok, _food_category} = Food.delete_food_category(food_category)

    conn
    |> put_flash(:info, "Food category deleted successfully.")
    |> redirect(to: Routes.food_category_path(conn, :index))
  end
end
