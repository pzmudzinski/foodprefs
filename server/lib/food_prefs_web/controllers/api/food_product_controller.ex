defmodule FoodPrefsWeb.API.FoodProductController do
  use FoodPrefsWeb, :controller

  alias FoodPrefs.Food
  alias FoodPrefs.FoodProduct

  def index(conn, params) do
    products = Food.list_products(params)
    json(conn, products)
  end

  def show(conn, %{"id" => id}) do
    product = Food.get_food_product!(id)
    json(conn, product)
  end

end
