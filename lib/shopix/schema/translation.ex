defmodule Shopix.Schema.Translation do
  use Ecto.Schema

  use Shopix.TranslationFields, translated_fields: ~w(value)

  schema "translations" do
    field :key, :string

    schema_translation_fields()
    timestamps()
  end
end
