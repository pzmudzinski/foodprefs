defmodule FoodPrefsWeb.FoodCategoryView do
  use FoodPrefsWeb, :view

  def categories_grouped_by_three(categories) do
    Enum.chunk_every(categories, 3)
  end
end
