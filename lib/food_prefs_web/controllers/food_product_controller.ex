defmodule FoodPrefsWeb.FoodProductController do
  use FoodPrefsWeb, :controller

  alias FoodPrefs.Food
  alias FoodPrefs.FoodProduct

  def index(conn, params) do
    products = Food.list_products(params)
    render(conn, "index.html", products: products)
  end

  def new(conn, _params) do
    changeset = Food.change_food_product(%FoodProduct{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"food_product" => food_product_params}) do
    case Food.create_food_product(food_product_params) do
      {:ok, food_product} ->
        conn
        |> put_flash(:info, "Food product created successfully.")
        |> redirect(to: Routes.food_product_path(conn, :show, food_product))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    food_product = Food.get_food_product!(id)
    render(conn, "show.html", food_product: food_product)
  end

  def edit(conn, %{"id" => id}) do
    food_product = Food.get_food_product!(id)
    changeset = Food.change_food_product(food_product)
    render(conn, "edit.html", food_product: food_product, changeset: changeset)
  end

  def update(conn, %{"id" => id, "food_product" => food_product_params}) do
    food_product = Food.get_food_product!(id)

    case Food.update_food_product(food_product, food_product_params) do
      {:ok, food_product} ->
        conn
        |> put_flash(:info, "Food product updated successfully.")
        |> redirect(to: Routes.food_product_path(conn, :show, food_product))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", food_product: food_product, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    food_product = Food.get_food_product!(id)
    {:ok, _food_product} = Food.delete_food_product(food_product)

    conn
    |> put_flash(:info, "Food product deleted successfully.")
    |> redirect(to: Routes.food_product_path(conn, :index))
  end
end
