defmodule ShopixWeb.Api.CartView do
  use ShopixWeb, :view
  alias ShopixWeb.Api.ProductView

  def render("show.json", %{order: order, locale: locale}) do
    %{
      order: order_json(order, locale)
    }
  end

  def order_json(order, locale) do
    %{
      id: order.id,
      total_quantity: order.total_quantity,
      line_items: Enum.map(order.line_items, &line_item_json(&1, locale)),
      price_items: order.price_items,
      total_price: order.total_price,
      completed_at: order.completed_at
    }
  end

  def line_item_json(line_item, locale) do
    %{
      id: line_item.id,
      quantity: line_item.quantity,
      product: ProductView.related_product_json(line_item.product, locale)
    }
  end
end
