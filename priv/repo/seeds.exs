# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     FoodPrefs.Repo.insert!(%FoodPrefs.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
Code.require_file("extract.exs", "priv/repo/seeds_html")

SeedExtract.get_seeds()
|> Enum.each(fn {categoryTitle, products} ->
  category = FoodPrefs.Repo.insert!(%FoodPrefs.FoodCategory{name: categoryTitle})

  food_products =
    products
    |> Enum.map(fn %{:kcal => kcal, :name => name} ->
      %{kcal: kcal, name: name, category_id: category.id}
    end)

  FoodPrefs.Repo.insert_all(FoodPrefs.FoodProduct, food_products)
end)
