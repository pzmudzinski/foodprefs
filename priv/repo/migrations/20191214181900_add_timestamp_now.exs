defmodule FoodPrefs.Repo.Migrations.AddTimestampNow do
  use Ecto.Migration

  def change do
    alter table(:food_products) do
      modify :inserted_at, :utc_datetime, default: fragment("NOW()")
    end
  end
end
