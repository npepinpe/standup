defmodule Standup.StandupController do
  use Standup.Web, :controller

  def index(conn, _params) do
    conn
      |> send_resp(200, "")
  end
end
