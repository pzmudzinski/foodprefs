defmodule FoodPrefs.Food do
  @moduledoc """
  The Food context.
  """

  import Ecto.Query, warn: false
  alias FoodPrefs.Repo

  alias FoodPrefs.FoodProduct

  @doc """
  Returns the list of products.

  ## Examples

      iex> list_products()
      [%FoodProduct{}, ...]

  """
  def list_products do
    Repo.all(FoodProduct)
  end

  def list_products(category_id) do
    FoodProduct
     |> where(category_id: ^category_id)
     |> Repo.all()
  end

  @doc """
  Gets a single food_product.

  Raises if the Food product does not exist.

  ## Examples

      iex> get_food_product!(123)
      %FoodProduct{}

  """
  def get_food_product!(id), do: Repo.get!(FoodProduct, id)

  @doc """
  Creates a food_product.

  ## Examples

      iex> create_food_product(%{field: value})
      {:ok, %FoodProduct{}}

      iex> create_food_product(%{field: bad_value})
      {:error, ...}

  """
  def create_food_product(attrs \\ %{}) do
    IO.puts "creating food product"
    %FoodProduct{}
     |> FoodProduct.changeset(attrs)
     |> Repo.insert(returning: true)
  end

  @doc """
  Updates a food_product.

  ## Examples

      iex> update_food_product(food_product, %{field: new_value})
      {:ok, %FoodProduct{}}

      iex> update_food_product(food_product, %{field: bad_value})
      {:error, ...}

  """
  def update_food_product(%FoodProduct{} = food_product, attrs) do
    food_product
     |> FoodProduct.changeset(attrs)
     |> Repo.update
  end

  @doc """
  Deletes a FoodProduct.

  ## Examples

      iex> delete_food_product(food_product)
      {:ok, %FoodProduct{}}

      iex> delete_food_product(food_product)
      {:error, ...}

  """
  def delete_food_product(%FoodProduct{} = food_product) do
    Repo.delete(food_product)
  end

  @doc """
  Returns a data structure for tracking food_product changes.

  ## Examples

      iex> change_food_product(food_product)
      %Todo{...}

  """
  def change_food_product(%FoodProduct{} = food_product) do
    FoodProduct.changeset(food_product)
  end

  alias FoodPrefs.FoodCategory

  @doc """
  Returns the list of categories.

  ## Examples

      iex> list_categories()
      [%FoodCategory{}, ...]

  """
  def list_categories do
    Repo.all(FoodPrefs.FoodCategory)
  end

  def list_categories_with_top_product(product_count \\ 10) do
    query = from list in FoodProduct,
      join: category in assoc(list, :category_id),
      group_by: list.category_id,
      order_by: [asc: :score],
      limit: ^product_count,
      select_merge: %{ category_name: category.name }

    query |> Repo.all
  end

  @doc """
  Gets a single food_category.

  Raises if the Food category does not exist.

  ## Examples

      iex> get_food_category!(123)
      %FoodCategory{}

  """
  def get_food_category!(id), do: Repo.get!(FoodCategory, id)

  @doc """
  Creates a food_category.

  ## Examples

      iex> create_food_category(%{field: value})
      {:ok, %FoodCategory{}}

      iex> create_food_category(%{field: bad_value})
      {:error, ...}

  """
  def create_food_category(attrs \\ %{}) do
    %FoodCategory{}
     |> FoodCategory.changeset(attrs)
     |> Repo.insert
  end

  @doc """
  Updates a food_category.

  ## Examples

      iex> update_food_category(food_category, %{field: new_value})
      {:ok, %FoodCategory{}}

      iex> update_food_category(food_category, %{field: bad_value})
      {:error, ...}

  """
  def update_food_category(%FoodCategory{} = food_category, attrs) do
    food_category
     |> FoodCategory.changeset(attrs)
     |> Repo.update
  end

  @doc """
  Deletes a FoodCategory.

  ## Examples

      iex> delete_food_category(food_category)
      {:ok, %FoodCategory{}}

      iex> delete_food_category(food_category)
      {:error, ...}

  """
  def delete_food_category(%FoodCategory{} = food_category) do
    Repo.delete(food_category)
  end

  @doc """
  Returns a data structure for tracking food_category changes.

  ## Examples

      iex> change_food_category(food_category)
      %Todo{...}

  """
  def change_food_category(%FoodCategory{} = food_category) do
    FoodCategory.changeset(food_category)
  end
end
