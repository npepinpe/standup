defmodule Standup.Router do
  use Standup.Web, :router

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

  pipeline :authenticate do
    plug Standup.Plugs.Authenticate
  end

  scope "/", Standup do
    pipe_through [:browser, :authenticate]
    get "/", StandupController, :index
    resources "/standups", StandupController, only: [:index, :show, :update]
  end

  scope "/", Standup do
    pipe_through :browser

    scope "/auth" do
      get "/login", SessionController, :new
      post "/login", SessionController, :create
      get "/logout", SessionController, :delete
    end

    resources "/users", UserController, only: [:new, :create]
  end
end
