defmodule FoodPrefs.Repo.Migrations.CreateFoodProducts do
  use Ecto.Migration

  def change do
    create table(:food_products) do
      add :name, :string
      add :notes, :text
      add :category_id, references(:food_categories, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:food_products, [:name])
    create index(:food_products, [:category_id])
  end
end
