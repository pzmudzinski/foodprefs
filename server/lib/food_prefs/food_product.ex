defmodule FoodPrefs.FoodProduct do
  use Ecto.Schema
  import Ecto.Changeset
  @derive {Jason.Encoder, only: [:id, :name, :notes, :kcal, :score]}

  schema "food_products" do
    field :name, :string
    field :notes, :string
    belongs_to :category, FoodPrefs.FoodCategory
    field :kcal, :integer
    field :score, :integer

    field(:rank, :integer, virtual: true)

    timestamps()
  end

  @doc false
  def changeset(food_product, attrs \\ %{}) do
    food_product
    |> cast(attrs, [:name, :notes, :category_id, :kcal, :score])
    |> validate_required([:name, :category_id])
    |> assoc_constraint(:category)
    |> unique_constraint(:name)
  end
end
