defmodule FoodPrefs.Repo.Migrations.CreateFoodCategories do
  use Ecto.Migration

  def change do
    create table(:food_categories) do
      add :name, :string
      add :notes, :text

      timestamps()
    end

    create unique_index(:food_categories, [:name])
  end
end
