defmodule InterviewWeb.Router do
  use InterviewWeb, :router
  import Phoenix.LiveView.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {InterviewWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", InterviewWeb do
    pipe_through :api
  end

  scope "/", InterviewWeb do
    pipe_through :browser

    get "/", PageController, :home

    live "/roles", RoleLive.Index, :index
    live "/roles/new", RoleLive.Index, :new
    live "/roles/:id/edit", RoleLive.Index, :edit
    live "/roles/:id", RoleLive.Show, :show
    live "/roles/:id/show/edit", RoleLive.Show, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", InterviewWeb do
  #   pipe_through :api
  # end
end
