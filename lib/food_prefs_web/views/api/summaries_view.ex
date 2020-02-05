defmodule FoodPrefsWeb.API.FoodCategoryView do
  use FoodPrefsWeb, :view

  def render("summaries.json", products) do
    %{
      summaries: render_many(products.summaries, FoodPrefsWeb.API.FoodCategoryView, "summary.json")
    }
  end

  def render("summary.json", products) do
    category = hd(products.food_category).category
    %{ category: category, products: products.food_category }
  end
end
