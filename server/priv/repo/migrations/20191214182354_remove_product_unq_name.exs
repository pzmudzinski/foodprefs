defmodule FoodPrefs.Repo.Migrations.RemoveProductUnqName do
  use Ecto.Migration

  def change do
    drop unique_index(:food_products, [:name])
  end
end
