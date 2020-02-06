defmodule FoodPrefsWeb.FoodCategoryController do
  use FoodPrefsWeb, :controller

  alias FoodPrefs.FoodPrefsWeb
  alias FoodPrefs.FoodCategory

  plug(:put_layout, {FoodPrefs.LayoutView, "torch.html"})

  def default(conn, _params) do
    redirect(conn, to: "/admin/food_categories")
  end

  def index(conn, params) do
    case FoodPrefsWeb.paginate_food_categories(params) do
      {:ok, assigns} ->
        render(conn, "index.html", assigns)
      error ->
        conn
        |> put_flash(:error, "There was an error rendering Food categories. #{inspect(error)}")
        |> redirect(to: Routes.food_category_path(conn, :index))
    end
  end

  def new(conn, _params) do
    changeset = FoodPrefsWeb.change_food_category(%FoodCategory{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"food_category" => food_category_params}) do
    case FoodPrefsWeb.create_food_category(food_category_params) do
      {:ok, food_category} ->
        conn
        |> put_flash(:info, "Food category created successfully.")
        |> redirect(to: Routes.food_category_path(conn, :show, food_category))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    food_category = FoodPrefsWeb.get_food_category!(id)
    render(conn, "show.html", food_category: food_category)
  end

  def edit(conn, %{"id" => id}) do
    food_category = FoodPrefsWeb.get_food_category!(id)
    changeset = FoodPrefsWeb.change_food_category(food_category)
    render(conn, "edit.html", food_category: food_category, changeset: changeset)
  end

  def update(conn, %{"id" => id, "food_category" => food_category_params}) do
    food_category = FoodPrefsWeb.get_food_category!(id)

    case FoodPrefsWeb.update_food_category(food_category, food_category_params) do
      {:ok, food_category} ->
        conn
        |> put_flash(:info, "Food category updated successfully.")
        |> redirect(to: Routes.food_category_path(conn, :show, food_category))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", food_category: food_category, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    food_category = FoodPrefsWeb.get_food_category!(id)
    {:ok, _food_category} = FoodPrefsWeb.delete_food_category(food_category)

    conn
    |> put_flash(:info, "Food category deleted successfully.")
    |> redirect(to: Routes.food_category_path(conn, :index))
  end
end
