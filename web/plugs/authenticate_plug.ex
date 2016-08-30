defmodule Standup.Plugs.Authenticate do
  require Logger
  import Plug.Conn
  import Phoenix.Controller, only: [redirect: 2, put_flash: 3]

  @redirect_path_key "auth.redirect_path"

  def init(default), do: default

  def call(conn, _default) do
    current_user = get_session(conn, :current_user)
    if current_user do
      assign(conn, :current_user, current_user)
    else
      conn
        |> put_flash(:error, 'You need to be signed in to view this page')
        |> put_session(@redirect_path_key, conn.request_path)
        |> redirect(to: Standup.Router.Helpers.session_path(conn, :new))
    end
  end

  def redirect(conn) do
    path = get_session(conn, @redirect_path_key) || Standup.Router.Helpers.standup_path(conn, :index)
    redirect(conn, to: path)
  end

  def set_current_user(conn, user) do
    put_session(conn, :current_user, user)
  end
end
