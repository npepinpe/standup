defmodule Standup.UserController do
  use Standup.Web, :controller
  alias Standup.User
  alias Standup.Repo

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    conn
      |> assign(:stylesheets, ["form"])
      |> assign(:title, "Register")
      |> render("new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.create_changeset(%User{}, user_params)

    case Repo.insert(changeset) do
      {:ok, _user} ->
        conn
          |> put_flash(:info, "Successfully registered!")
          |> redirect(to: session_path(conn, :new))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
