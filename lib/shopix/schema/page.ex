defmodule Shopix.Schema.Page do
  use Ecto.Schema

  use Shopix.TranslationFields, slug: :name, translated_fields: ~w(name content slug)

  schema "pages" do
    field :key, :string
    field :images_group_url, :string
    field :edit_html_only, :boolean, default: false

    schema_translation_fields()
    timestamps()
  end
end
