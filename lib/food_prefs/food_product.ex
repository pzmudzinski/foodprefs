defmodule FoodPrefs.FoodProduct do
  use Ecto.Schema
  import Ecto.Changeset

  schema "food_products" do
    field :name, :string
    field :notes, :string
    field :category_id, :id
    field :kcal, :integer
    field :score, :integer

    timestamps()
  end

  @doc false
  def changeset(food_product, attrs) do
    food_product
    |> cast(attrs, [:name, :notes])
    |> validate_required([:name, :notes])
    |> unique_constraint(:name)
  end
end
