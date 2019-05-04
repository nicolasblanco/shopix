defmodule Shopix.Admin.Property do
  import Ecto.Changeset
  use Shopix.TranslationFields, translated_fields: ~w(name)

  alias Shopix.Schema.Property

  def changeset(%Property{} = property, attrs) do
    property
    |> cast(attrs, [:key] ++ localized_fields())
    |> validate_required([:key])
    |> validate_format(:key, ~r/\A[a-z0-9\-_]{3,}\z/)
    |> unique_constraint(:key)
  end
end
