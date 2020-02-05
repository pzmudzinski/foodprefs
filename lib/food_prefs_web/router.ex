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
    plug CORSPlug, origin: "*"
  end

  scope "/admin", FoodPrefsWeb do
    pipe_through :browser
  end

  scope "/api", FoodPrefsWeb.API do
    pipe_through :api

    resources "/categories", FoodCategoryController, only: [:index, :show]
    get "/categories/summaries", FoodCategoryController, :summaries
    get "/categories/:id/products", FoodCategoryController, :get_products
    resources "/products", FoodProductController, only: [:index, :show]
  end
end
