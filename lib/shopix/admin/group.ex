defmodule Shopix.Admin.Group do
  import Ecto.Changeset

  alias Shopix.Schema.Group

  def changeset(%Group{} = group, attrs) do
    group
    |> cast(attrs, [:key])
    |> validate_required([:key])
    |> validate_format(:key, ~r/\A[a-z0-9\-_]{3,}\z/)
    |> unique_constraint(:key)
  end
end
