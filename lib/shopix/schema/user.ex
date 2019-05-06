defmodule Shopix.Schema.User do
  use Ecto.Schema

  schema "admin_users" do
    field :email, :string
    field :encrypted_password, :string
    field :password, :string, virtual: true

    timestamps()
  end
end
