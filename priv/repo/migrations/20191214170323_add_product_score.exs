defmodule FoodPrefs.Repo.Migrations.AddProductScore do
  use Ecto.Migration

  def change do
    alter table(:food_products) do
      add :score, :integer, default: 100
    end
  end
end
