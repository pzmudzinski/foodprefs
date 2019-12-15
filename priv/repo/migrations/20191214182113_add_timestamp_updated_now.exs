defmodule FoodPrefs.Repo.Migrations.AddTimestampUpdatedNow do
  use Ecto.Migration

  def change do
    alter table(:food_products) do
      modify :updated_at, :utc_datetime, default: fragment("NOW()")
    end
  end
end
