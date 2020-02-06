defmodule FoodPrefsWeb.API.FoodCategoryController do
  use FoodPrefsWeb, :controller

  alias FoodPrefs.Food
  alias FoodPrefs.FoodCategory



  def index(conn, _params) do
    categories = Food.list_categories()
    json(conn, categories)
  end

  def summaries(conn) do
    summaries = Food.list_categories_with_top_product(10)
    render(conn, "summaries.json", summaries: summaries)
  end

  def get_products(conn, %{"id" => id}) do
    products = Food.list_products_by_category_id(id)
    json(conn, products)
  end

  def show(conn, %{"id" => id}) when id == "summaries", do: summaries(conn)

  def show(conn, %{"id" => id}) do
    category = Food.get_food_category!(id)
    json(conn, category)
  end

end
