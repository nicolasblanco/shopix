defmodule ShopixWeb.Front.ProductView do
  use ShopixWeb, :view

  def product_property_for(product, key) do
    Enum.find(product.product_properties, fn product_property ->
      product_property.property.key == key
    end)
  end

  def in_groups([], _), do: []
  def in_groups(enum, number_of_groups) do
    size = round(Enum.count(enum) / number_of_groups)
    Enum.chunk_every(enum, size, size, [])
  end

  def properties_prefixed_by(product_properties, prefix) do
    Enum.filter(product_properties, fn(product_property) ->
      String.starts_with?(product_property.property.key, prefix)
    end)
  end
end
