defmodule ShopixWeb.Front.CartController do
  use ShopixWeb, :controller
  alias Shopix.Front

  plug ShopixWeb.Plug.Translations

  def show(conn, _params) do
    render(conn, "show.html", order: conn.assigns.current_order)
  end

  def add(conn, %{"product_id" => product_id}) do
    product = Front.get_product!(product_id)

    order =
      Front.create_or_add_order_with_product!(
        conn.assigns.current_order,
        product,
        conn.assigns.global_config
      )

    conn
    |> put_session(:order_id, order.id)
    |> redirect(to: cart_path(conn, :show, conn.assigns.current_locale))
  end

  def line_item_decrease(conn, %{"line_item_id" => line_item_id}) do
    Front.order_line_item_decrease!(conn.assigns.current_order, line_item_id)

    conn
    |> redirect(to: cart_path(conn, :show, conn.assigns.current_locale))
  end

  def line_item_increase(conn, %{"line_item_id" => line_item_id}) do
    Front.order_line_item_increase!(conn.assigns.current_order, line_item_id)

    conn
    |> redirect(to: cart_path(conn, :show, conn.assigns.current_locale))
  end

  def line_item_delete(conn, %{"line_item_id" => line_item_id}) do
    Front.order_line_item_delete!(conn.assigns.current_order, line_item_id)

    conn
    |> redirect(to: cart_path(conn, :show, conn.assigns.current_locale))
  end
end
