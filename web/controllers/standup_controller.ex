defmodule Standup.StandupController do
  use Standup.Web, :controller

  def index(conn, _params) do
    conn
      |> assign(:header, true)
      |> render("index.html")
  end
end
