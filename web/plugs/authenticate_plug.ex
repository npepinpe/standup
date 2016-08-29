defmodule Standup.Plugs.Authenticate do
  require Logger
  import Plug.Conn
  import Phoenix.Controller, only: [redirect: 2, put_flash: 3]

  def init(default), do: default

  def call(conn, _default) do
    Logger.debug("Well hello there")
    current_user = get_session(conn, :current_user)
    if current_user do
      assign(conn, :current_user, current_user)
    else
      conn
        |> put_flash(:error, 'You need to be signed in to view this page')
        |> redirect(to: Standup.Router.Helpers.session_path(conn, :new))
    end
  end
end
