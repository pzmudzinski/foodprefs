defmodule FoodPrefs.FoodCategory do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :name, :notes]}

  schema "food_categories" do
    field :name, :string
    field :notes, :string
    has_many :products, FoodPrefs.FoodProduct, foreign_key: :category_id

    timestamps()
  end

  @doc false
  def changeset(food_category, attrs \\ %{}) do
    food_category
    |> cast(attrs, [:name, :notes])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
