defmodule Standup.UserController do
  use Standup.Web, :controller
  alias Standup.User
  alias Standup.Repo

  def new(conn, params) do
    changeset = User.changeset(%User{})
    new(conn, params, changeset)
  end

  def new(conn, _params, changeset) do
    conn
      |> assign(:stylesheets, ["form"])
      |> assign(:title, "Register")
      |> render("new.html", changeset: changeset)
  end

  def create(conn, params = %{"user" => user_params}) do
    changeset = User.create_changeset(%User{}, user_params)

    case Repo.insert(changeset) do
      {:ok, _user} ->
        conn
          |> put_flash(:info, "Successfully registered!")
          |> redirect(to: session_path(conn, :new))
      {:error, changeset} ->
        conn
          |> put_flash(:error, "Some fields are invalid; see below")
          |> new(params, changeset)
    end
  end
end
