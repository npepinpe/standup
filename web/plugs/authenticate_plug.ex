defmodule Standup.Plugs.Authenticate do
  require Logger
  import Plug.Conn
  alias Standup.User
  alias Standup.Repo
  import Phoenix.Controller, only: [redirect: 2, put_flash: 3]

  @redirect_path_key "auth.redirect_path"

  def init(default), do: default

  def call(conn, _default) do
    case current_user(conn) do
      nil ->
        conn
          |> put_flash(:error, 'You need to be signed in to view this page')
          |> put_session(@redirect_path_key, conn.request_path)
          |> redirect(to: Standup.Router.Helpers.session_path(conn, :new))
      user ->
        assign(conn, :current_user, user)
    end
  end

  def current_user(conn) do
    id = get_session(conn, :current_user_id)
    if id, do: Repo.get(User, id)
  end

  def redirect(conn) do
    path = get_session(conn, @redirect_path_key) || Standup.Router.Helpers.standup_path(conn, :index)
    redirect(conn, to: path)
  end

  def set_current_user_id(conn, id) do
    put_session(conn, :current_user_id, id)
  end

  def delete(conn) do
    conn
      |> delete_session(:current_user_id)
      |> delete_session(@redirect_path_key)
  end
end
