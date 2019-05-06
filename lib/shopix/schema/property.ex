defmodule Shopix.Schema.Property do
  use Ecto.Schema

  use Shopix.TranslationFields, translated_fields: ~w(name)

  schema "properties" do
    field :key, :string
    schema_translation_fields()

    timestamps()
  end
end
