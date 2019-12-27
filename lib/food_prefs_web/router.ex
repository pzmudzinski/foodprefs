defmodule FoodPrefsWeb.Router do
  use FoodPrefsWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", FoodPrefsWeb do
    pipe_through :browser

    get "/", FoodCategoryController, :index
    resources "/products", FoodProductController, only: [:index, :show]
    resources "/categories", FoodCategoryController, only: [:index, :show]

  end

  # Other scopes may use custom stacks.
  # scope "/api", FoodPrefsWeb do
  #   pipe_through :api
  # end
end
