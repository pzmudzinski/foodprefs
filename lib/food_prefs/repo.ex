defmodule FoodPrefs.Repo do
  use Ecto.Repo,
    otp_app: :food_prefs,
    adapter: Ecto.Adapters.Postgres
end

defmodule FoodPrefs.Food do
  alias FoodPrefs.Repo

  def list_categories do
    Repo.all(FoodPrefs.FoodCategory)
  end
end
