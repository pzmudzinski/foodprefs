defmodule FoodPrefsWeb.PageController do
  use FoodPrefsWeb, :controller

  alias FoodPrefs.Food

  def index(conn, _params) do
    render(conn, "index.html", categories: Food.list_categories())
  end
end
