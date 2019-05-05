defmodule Shopix.TranslationFields do
  @moduledoc """
  Usage:
      defmodule Product do
        use Ecto.Schema

        import Ecto.Changeset
        use Shopix.TranslationFields, slug: :name, translated_fields: ~w(name description slug)

        schema "products" do
          field :price, :integer
          field :sku, :string
          field :slug, :string

          schema_translation_fields()
          timestamps()
        end

    Then for each `translated_fields` it will define one persistent field containing the translations
    as a map (named `fieldname_translations`).
  """
  defmacro __using__(opts) do
    quote do
      import Ecto.Changeset
      import Shopix.TranslationFields

      @translated_fields unquote(opts[:translated_fields])
      if unquote(opts[:slug]) do
        @slug unquote(opts[:slug])

        def slugify_map(data) do
          data
          |> Enum.reject(fn {_, v} -> is_nil(v) end)
          |> Enum.map(fn {locale, value} -> {locale, Slugger.slugify_downcase(value)} end)
          |> Map.new()
        end

        def change_slugs(data) do
          if slug_map = get_field(data, :"#{@slug}_translations") do
            data
            |> put_change(:slug_translations, slugify_map(slug_map))
          else
            data
          end
        end
      end

      def localized_fields do
        @translated_fields
        |> Enum.map(fn field -> :"#{field}_translations" end)
      end
    end
  end

  defmacro schema_translation_fields do
    quote do
      @translated_fields
      |> Enum.each(fn field ->
        field :"#{field}_translations", :map, default: %{}
      end)
    end
  end
end
