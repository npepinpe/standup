defmodule Standup.User do
  use Standup.Web, :model

  schema "users" do
    field :email, :string
    field :password, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:email, :password])
    |> validate_required([:email, :password])
    |> unique_constraint(:email)
    |> hash_password
  end

  defp hash_password(changeset) do
    if password = get_change(changeset, :password) do
      hashed = :crypto.hash(:sha256, password) |> Base.encode16
      changeset |> put_change(:password, hashed)
    else
      changeset
    end
  end
end
