defmodule Standup.User do
  use Standup.Web, :model

  schema "users" do
    field :email, :string
    field :password, :string

    timestamps()

    field :password_plain, :string, virtual: true
    field :password_plain_confirmation, :string, virtual: true
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
      |> cast(params, [:email, :password_plain, :password_plain_confirmation])
      |> validate_required([:email, :password_plain])
      |> hash_password
  end

  def create_changeset(struct, params \\ %{}) do
    changeset(struct, params)
      |> unique_constraint(:email)
      |> validate_format(:email, ~r/@/)
      |> validate_length(:password_plain, min: 6)
      |> validate_confirmation(:password_plain, required: true, message: "does not match password")
  end

  defp hash_password(changeset) do
    if password = get_change(changeset, :password_plain) do
      hashed = :crypto.hash(:sha256, password) |> Base.encode16
      changeset |> put_change(:password, hashed)
    else
      changeset
    end
  end
end
