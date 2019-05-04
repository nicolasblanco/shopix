defmodule Shopix.Admin.ProductProperty do
  import Ecto.Changeset
  use Shopix.TranslationFields, translated_fields: ~w(value)

  alias Shopix.Schema.ProductProperty

  def changeset(%ProductProperty{} = product_property, attrs) do
    product_property
    |> cast(attrs, [:product_id, :property_id] ++ localized_fields())
    |> validate_required([:property_id])
    |> unique_constraint(:property_id, name: :product_property_index)
  end
end
