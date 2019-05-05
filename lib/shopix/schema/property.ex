defmodule Shopix.Schema.Property do
  use Ecto.Schema

  @timestamps_opts [
    type: Timex.Ecto.DateTime,
    autogenerate: {Timex.Ecto.DateTime, :autogenerate, []}
  ]

  use Shopix.TranslationFields, translated_fields: ~w(name)

  schema "properties" do
    field :key, :string
    schema_translation_fields()

    timestamps()
  end
end
