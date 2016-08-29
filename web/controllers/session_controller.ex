defmodule Standup.SessionController do
  use Standup.Web, :controller

  def new(conn, _params) do
    conn
      |> assign(:stylesheets, ["auth.css"])
      |> assign(:title, "Sign in")
      |> render("new.html")
  end

  def create(_conn, _params) do
  end

  def delete(_conn, _params) do
  end
end
