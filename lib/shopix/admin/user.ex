defmodule Shopix.Admin.User do
  import Ecto.Changeset

  alias Comeonin.Bcrypt
  alias Shopix.Schema.User

  def registration_changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :password])
    |> validate_required([:email, :password])
    |> put_encrypted_password()
    |> unique_constraint(:email)
  end

  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :password, :instagram_auth])
    |> validate_required([:email])
    |> put_encrypted_password()
    |> unique_constraint(:email)
  end

  def valid_password?(%User{encrypted_password: encrypted_password}, password) do
    Bcrypt.checkpw(password, encrypted_password)
  end

  defp put_encrypted_password(
         %Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset
       ) do
    changeset
    |> put_change(:encrypted_password, encrypt_password(password))
    |> put_change(:password, nil)
  end

  defp put_encrypted_password(%Ecto.Changeset{} = changeset), do: changeset

  defp encrypt_password(password) do
    Bcrypt.hashpwsalt(password)
  end
end
