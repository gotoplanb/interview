defmodule InterviewWeb.Router do
  use InterviewWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", InterviewWeb do
    pipe_through :api
  end
end
