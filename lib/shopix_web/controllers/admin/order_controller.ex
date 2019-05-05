defmodule ShopixWeb.Admin.OrderController do
  use ShopixWeb, :controller

  alias Shopix.Admin

  def index(conn, params) do
    page = Admin.list_orders(params)

    render(conn, "index.html",
      orders: page.entries,
      page: page
    )
  end

  def show(conn, %{"id" => id}) do
    order = Admin.get_order!(id)

    render(conn, "show.html", order: order)
  end
end
