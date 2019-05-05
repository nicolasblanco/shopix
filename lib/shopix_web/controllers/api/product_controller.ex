defmodule ShopixWeb.Api.ProductController do
  use ShopixWeb, :controller
  alias Shopix.Front

  def index(conn, %{"page" => _page} = params) do
    page = Front.list_products(params)

    render(conn, "index.json",
      products: page.entries,
      locale: conn.assigns.current_locale,
      page: page
    )
  end

  def show(conn, %{"id" => id}) do
    product = Front.get_product_by_slug!(id, conn.assigns.current_locale)
    related_products = Front.get_related_products(product.id)
    next_product = Front.next_product(product)
    previous_product = Front.previous_product(product)

    render(conn, "show.json",
      product: product,
      locale: conn.assigns.current_locale,
      related_products: related_products,
      next_product: next_product,
      previous_product: previous_product
    )
  end
end
