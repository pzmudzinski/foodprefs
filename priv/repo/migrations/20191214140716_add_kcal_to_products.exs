defmodule FoodPrefs.Repo.Migrations.AddKcalToProducts do
  use Ecto.Migration

  def change do
    alter table(:food_products) do
      add :kcal, :integer
    end

  end
end
