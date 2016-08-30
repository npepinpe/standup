defmodule Standup.SessionController do
  use Standup.Web, :controller
  alias Standup.User
  alias Standup.Repo
  alias Standup.Plugs.Authenticate

  def new(conn, _params) do
    conn
      |> assign(:stylesheets, ["form"])
      |> assign(:title, "Sign in")
      |> render("new.html")
  end

  def create(conn, %{ "session" => session_params }) do
    changeset = User.changeset(%User{}, session_params)
    email = Ecto.Changeset.get_change(changeset, :email)
    password = Ecto.Changeset.get_change(changeset, :password)

    case Repo.get_by(User, [email: email, password: password]) do
      nil ->
        conn
          |> put_flash(:error, "No such email/password pair")
          |> new(%{ "session" => session_params })
      user ->
        conn
          |> put_flash(:info, "Successfully logged in")
          |> Authenticate.set_current_user_id(user.id)
          |> Authenticate.redirect
      end
  end

  def delete(conn, _params) do
    conn
      |> Authenticate.delete
      |> put_flash(:info, "Logged out")
      |> Authenticate.redirect
  end
end
