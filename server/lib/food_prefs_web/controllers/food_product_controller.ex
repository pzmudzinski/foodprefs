defmodule FoodPrefsWeb.FoodProductController do
  use FoodPrefsWeb, :controller

  alias FoodPrefs.FoodPrefsWeb
  alias FoodPrefs.FoodProduct

  plug(:put_layout, {FoodPrefs.LayoutView, "torch.html"})

  def index(conn, params) do
    IO.puts "index_params"
    IO.inspect params

    case FoodPrefsWeb.paginate_food_products(params) do
      {:ok, assigns} ->
        with_categories = Map.put(assigns, :categories, Enum.map(FoodPrefs.Food.list_categories(), fn cat -> [key: cat.name, value: cat.id] end))
        render(conn, "index.html", with_categories)
      error ->
        conn
        |> put_flash(:error, "There was an error rendering Food products. #{inspect(error)}")
        |> redirect(to: Routes.food_product_path(conn, :index))
    end
  end

  def select_categories do
    FoodPrefsWeb.list_food_categories()
     |> Enum.map(fn cat -> {cat.name, cat.id} end)
  end

  def new(conn, _params) do
    changeset = FoodPrefsWeb.change_food_product(%FoodProduct{})
    render(conn, "new.html", [changeset: changeset, categories: select_categories()])
  end

  def create(conn, %{"food_product" => food_product_params}) do
    case FoodPrefsWeb.create_food_product(food_product_params) do
      {:ok, food_product} ->
        conn
        |> put_flash(:info, "Food product created successfully.")
        |> redirect(to: Routes.food_product_path(conn, :show, food_product))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    food_product = FoodPrefsWeb.get_food_product!(id)
    render(conn, "show.html", food_product: food_product)
  end

  def edit(conn, %{"id" => id}) do
    food_product = FoodPrefsWeb.get_food_product!(id)
    changeset = FoodPrefsWeb.change_food_product(food_product)
    render(conn, "edit.html", food_product: food_product, changeset: changeset)
  end

  def update(conn, %{"id" => id, "food_product" => food_product_params}) do
    food_product = FoodPrefsWeb.get_food_product!(id)

    case FoodPrefsWeb.update_food_product(food_product, food_product_params) do
      {:ok, food_product} ->
        conn
        |> put_flash(:info, "Food product updated successfully.")
        |> redirect(to: Routes.food_product_path(conn, :show, food_product))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", food_product: food_product, changeset: changeset)
    end
  end

  def batch_update(conn, %{ "score" => score, "category" => %{ "category_id_equals" => category_id }}) do
    IO.puts "batch_update"
    IO.puts score
    IO.puts category_id

    {count, nil} = FoodPrefsWeb.update_food_products(category_id, score)
    conn
      |> put_flash(:info, "Batch update success. #{count}")
      |> redirect(to: Routes.food_product_path(conn, :index))

  end

  def delete(conn, %{"id" => id}) do
    food_product = FoodPrefsWeb.get_food_product!(id)
    {:ok, _food_product} = FoodPrefsWeb.delete_food_product(food_product)

    conn
    |> put_flash(:info, "Food product deleted successfully.")
    |> redirect(to: Routes.food_product_path(conn, :index))
  end
end
