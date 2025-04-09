defmodule InterviewWeb.PageController do
  use InterviewWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
