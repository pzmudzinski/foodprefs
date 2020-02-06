defmodule FoodPrefs.FoodPrefsWeb do
  @moduledoc """
  The FoodPrefsWeb context.
  """

  import Ecto.Query, warn: false
  alias FoodPrefs.Repo

  import Torch.Helpers, only: [sort: 1, paginate: 4]
  import Filtrex.Type.Config

  alias FoodPrefs.FoodCategory

  @pagination [page_size: 15]
  @pagination_distance 5

  @doc """
  Paginate the list of food_categories using filtrex
  filters.

  ## Examples

      iex> list_food_categories(%{})
      %{food_categories: [%FoodCategory{}], ...}
  """
  @spec paginate_food_categories(map) :: {:ok, map} | {:error, any}
  def paginate_food_categories(params \\ %{}) do
    params =
      params
      |> Map.put_new("sort_direction", "desc")
      |> Map.put_new("sort_field", "inserted_at")

    {:ok, sort_direction} = Map.fetch(params, "sort_direction")
    {:ok, sort_field} = Map.fetch(params, "sort_field")

    with {:ok, filter} <- Filtrex.parse_params(filter_config(:food_categories), params["food_category"] || %{}),
         %Scrivener.Page{} = page <- do_paginate_food_categories(filter, params) do
      {:ok,
        %{
          food_categories: page.entries,
          page_number: page.page_number,
          page_size: page.page_size,
          total_pages: page.total_pages,
          total_entries: page.total_entries,
          distance: @pagination_distance,
          sort_field: sort_field,
          sort_direction: sort_direction
        }
      }
    else
      {:error, error} -> {:error, error}
      error -> {:error, error}
    end
  end

  defp do_paginate_food_categories(filter, params) do
    FoodCategory
    |> Filtrex.query(filter)
    |> order_by(^sort(params))
    |> paginate(Repo, params, @pagination)
  end

  @doc """
  Returns the list of food_categories.

  ## Examples

      iex> list_food_categories()
      [%FoodCategory{}, ...]

  """
  def list_food_categories do
    Repo.all(FoodCategory)
  end

  @doc """
  Gets a single food_category.

  Raises `Ecto.NoResultsError` if the Food category does not exist.

  ## Examples

      iex> get_food_category!(123)
      %FoodCategory{}

      iex> get_food_category!(456)
      ** (Ecto.NoResultsError)

  """
  def get_food_category!(id), do: Repo.get!(FoodCategory, id)

  @doc """
  Creates a food_category.

  ## Examples

      iex> create_food_category(%{field: value})
      {:ok, %FoodCategory{}}

      iex> create_food_category(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_food_category(attrs \\ %{}) do
    %FoodCategory{}
    |> FoodCategory.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a food_category.

  ## Examples

      iex> update_food_category(food_category, %{field: new_value})
      {:ok, %FoodCategory{}}

      iex> update_food_category(food_category, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_food_category(%FoodCategory{} = food_category, attrs) do
    food_category
    |> FoodCategory.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a FoodCategory.

  ## Examples

      iex> delete_food_category(food_category)
      {:ok, %FoodCategory{}}

      iex> delete_food_category(food_category)
      {:error, %Ecto.Changeset{}}

  """
  def delete_food_category(%FoodCategory{} = food_category) do
    Repo.delete(food_category)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking food_category changes.

  ## Examples

      iex> change_food_category(food_category)
      %Ecto.Changeset{source: %FoodCategory{}}

  """
  def change_food_category(%FoodCategory{} = food_category) do
    FoodCategory.changeset(food_category, %{})
  end

  defp filter_config(:food_categories) do
    defconfig do
      text :name
        text :notes

    end
  end

  import Torch.Helpers, only: [sort: 1, paginate: 4]
  import Filtrex.Type.Config

  alias FoodPrefs.FoodProduct

  @pagination [page_size: 15]
  @pagination_distance 5

  @doc """
  Paginate the list of food_products using filtrex
  filters.

  ## Examples

      iex> list_food_products(%{})
      %{food_products: [%FoodProduct{}], ...}
  """
  @spec paginate_food_products(map) :: {:ok, map} | {:error, any}
  def paginate_food_products(params \\ %{}) do
    params =
      params
      |> Map.put_new("sort_direction", "desc")
      |> Map.put_new("sort_field", "inserted_at")

    {:ok, sort_direction} = Map.fetch(params, "sort_direction")
    {:ok, sort_field} = Map.fetch(params, "sort_field")

    with {:ok, filter} <- Filtrex.parse_params(filter_config(:food_products), params["food_product"] || %{}),
         %Scrivener.Page{} = page <- do_paginate_food_products(filter, params) do
      {:ok,
        %{
          food_products: page.entries,
          page_number: page.page_number,
          page_size: page.page_size,
          total_pages: page.total_pages,
          total_entries: page.total_entries,
          distance: @pagination_distance,
          sort_field: sort_field,
          sort_direction: sort_direction
        }
      }
    else
      {:error, error} -> {:error, error}
      error -> {:error, error}
    end
  end

  defp do_paginate_food_products(filter, params) do
    category_params = Map.get(params, "category")
    params = Map.drop(params, ["category"])

    FoodProduct
    |> Filtrex.query(filter)
    |> category_filters(category_params)
    |> order_by(^sort(params))
    |> preload(:category)
    |> paginate(Repo, params, @pagination)
  end

  defp category_filters(query, nil), do: query

  defp category_filters(query, params) do
    search_string = "%#{params["category_id_equals"]}%"

    from(u in query,
      join: c in assoc(u, :category),
      where: c.id == ^params["category_id_equals"],
      group_by: u.id
    )
  end

  @doc """
  Returns the list of food_products.

  ## Examples

      iex> list_food_products()
      [%FoodProduct{}, ...]

  """
  def list_food_products do
    FoodProduct
    |> Repo.all()
    |> Repo.preload(:category)
  end

  def update_food_products(category_id, score) do
    FoodProduct
     |> where(category_id: ^category_id)
     |> Repo.update_all(set: [score: score])
  end

  @doc """
  Gets a single food_product.

  Raises `Ecto.NoResultsError` if the Food product does not exist.

  ## Examples

      iex> get_food_product!(123)
      %FoodProduct{}

      iex> get_food_product!(456)
      ** (Ecto.NoResultsError)

  """
  def get_food_product!(id) do
    FoodProduct
    |> Repo.get!(id)
    |> Repo.preload(:category)
  end

  @doc """
  Creates a food_product.

  ## Examples

      iex> create_food_product(%{field: value})
      {:ok, %FoodProduct{}}

      iex> create_food_product(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_food_product(attrs \\ %{}) do
    %FoodProduct{}
    |> FoodProduct.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a food_product.

  ## Examples

      iex> update_food_product(food_product, %{field: new_value})
      {:ok, %FoodProduct{}}

      iex> update_food_product(food_product, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_food_product(%FoodProduct{} = food_product, attrs) do
    food_product
    |> FoodProduct.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a FoodProduct.

  ## Examples

      iex> delete_food_product(food_product)
      {:ok, %FoodProduct{}}

      iex> delete_food_product(food_product)
      {:error, %Ecto.Changeset{}}

  """
  def delete_food_product(%FoodProduct{} = food_product) do
    Repo.delete(food_product)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking food_product changes.

  ## Examples

      iex> change_food_product(food_product)
      %Ecto.Changeset{source: %FoodProduct{}}

  """
  def change_food_product(%FoodProduct{} = food_product) do
    FoodProduct.changeset(food_product, %{})
  end

  defp filter_config(:food_products) do
    defconfig do
      text :name
        text :notes
        number :score
        number :kcal
        number :category_id_equals

    end
  end
end
