defmodule Shopix.Schema.Product do
  use Ecto.Schema

  use Shopix.TranslationFields, slug: :name, translated_fields: ~w(name description slug)

  alias Shopix.Schema.{ProductProperty, Group}

  schema "products" do
    field :price, Money.Ecto.Type
    field :sku, :string
    field :images_group_url, :string
    field :displayed, :boolean, default: true

    has_many :product_properties, ProductProperty, on_replace: :delete
    many_to_many :groups, Group, join_through: "products_groups", on_replace: :delete

    schema_translation_fields()
    timestamps()
  end
end
