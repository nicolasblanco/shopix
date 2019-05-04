defmodule ShopixWeb.Api.CartController do
  use ShopixWeb, :controller
  alias Shopix.Front

  def show(conn, %{"id" => id}) do
    order = Front.get_order(id, conn.assigns.global_config)

    render conn, "show.json", order: order, locale: conn.assigns.current_locale
  end

  def add(conn, %{"product_id" => product_id} = params) do
    order = if params["order_id"], do: Front.get_order(params["order_id"], conn.assigns.global_config), else: nil
    product = Front.get_product!(product_id)

    order = Front.create_or_add_order_with_product!(order, product, conn.assigns.global_config)
    order = Front.get_order(order.id, conn.assigns.global_config)

    render conn, "show.json", order: order, locale: conn.assigns.current_locale
  end

  def line_item_decrease(conn, %{"line_item_id" => line_item_id, "order_id" => order_id}) do
    Front.order_line_item_decrease!(Front.get_order(order_id, conn.assigns.global_config), line_item_id)

    order = Front.get_order(order_id, conn.assigns.global_config)
    render conn, "show.json", order: order, locale: conn.assigns.current_locale
  end

  def line_item_increase(conn, %{"line_item_id" => line_item_id, "order_id" => order_id}) do
    Front.order_line_item_increase!(Front.get_order(order_id, conn.assigns.global_config), line_item_id)

    order = Front.get_order(order_id, conn.assigns.global_config)
    render conn, "show.json", order: order, locale: conn.assigns.current_locale
  end

  def line_item_delete(conn, %{"line_item_id" => line_item_id, "order_id" => order_id}) do
    Front.order_line_item_delete!(Front.get_order(order_id, conn.assigns.global_config), line_item_id)

    order = Front.get_order(order_id, conn.assigns.global_config)
    render conn, "show.json", order: order, locale: conn.assigns.current_locale
  end
end
