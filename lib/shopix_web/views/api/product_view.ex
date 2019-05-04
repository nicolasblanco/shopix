defmodule ShopixWeb.Api.ProductView do
  use ShopixWeb, :view

  def render("index.json", %{products: products, locale: locale, page: page}) do
    %{
      products: Enum.map(products, &related_product_json(&1, locale)),
      locale: locale,
      page_size: page.page_size,
      total_pages: page.total_pages
    }
  end

  def render("show.json", %{product: product, related_products: related_products, locale: locale, previous_product: previous_product, next_product: next_product}) do
    %{
      product: product_json(product, locale),
      related_products: Enum.map(related_products, &related_product_json(&1, locale)),
      previous_product: related_product_json(previous_product, locale),
      next_product: related_product_json(next_product, locale),
      locale: locale
    }
  end

  def product_json(product, locale) do
    %{
      id: product.id,
      sku: product.sku,
      price: product.price,
      name: product.name_translations[locale],
      description: product.description_translations[locale],
      properties: Enum.map(product.product_properties, &product_property_json(&1, locale)),
      images: images_with_index(product),
      slug: t_field(product, :slug, locale)
    }
  end

  def related_product_json(nil, _), do: nil
  def related_product_json(product, locale) do
    %{
      id: product.id,
      slug: t_field(product, :slug, locale),
      thumb_url: thumb_url(product),
      name: product.name_translations[locale],
      price: product.price
    }
  end

  def product_property_json(product_property, locale) do
    %{
      key: product_property.property.key,
      name: t_field(product_property.property, :name, locale),
      value: t_field(product_property, :value, locale)
    }
  end
end
