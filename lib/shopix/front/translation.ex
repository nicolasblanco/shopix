defmodule Shopix.Front.Translation do
  import Ecto.Changeset

  alias Shopix.Schema.{Translation}

  def changeset_create_key(key) do
    change(%Translation{}, %{key: key})
    |> unique_constraint(:key)
  end
end
