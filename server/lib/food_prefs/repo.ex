defmodule FoodPrefs.Repo do
  use Ecto.Repo,
    otp_app: :food_prefs,
    adapter: Ecto.Adapters.Postgres
end
