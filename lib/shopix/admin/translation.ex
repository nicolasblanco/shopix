defmodule Shopix.Admin.Translation do
  import Ecto.Changeset
  alias Shopix.Schema.Translation
  use Shopix.TranslationFields, translated_fields: ~w(value)

  def changeset(%Translation{} = translation, attrs) do
    translation
    |> cast(attrs, [:key] ++ localized_fields())
    |> validate_required([:key])
    |> validate_format(:key, ~r/\A[0-9a-zA-Z_\.]{3,}\z/)
    |> unique_constraint(:key)
  end
end
