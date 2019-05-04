defmodule Shopix.Schema.ProductProperty do
  use Ecto.Schema
  @timestamps_opts [type: Timex.Ecto.DateTime,
                    autogenerate: {Timex.Ecto.DateTime, :autogenerate, []}]

  import Ecto.Changeset

  use Shopix.TranslationFields, translated_fields: ~w(value)
  alias Shopix.Schema.{Property, Product}

  schema "products_properties" do
    belongs_to :product, Product
    belongs_to :property, Property

    schema_translation_fields()

    timestamps()
  end
end
