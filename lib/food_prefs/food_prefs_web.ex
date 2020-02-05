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
end
