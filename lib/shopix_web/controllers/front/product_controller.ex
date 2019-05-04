defmodule ShopixWeb.Front.ProductController do
  use ShopixWeb, :controller
  alias Shopix.Front

  plug ShopixWeb.Plug.Translations

  def show(conn, %{"id" => id}) do
    product = Front.get_product_by_slug!(id, conn.assigns.current_locale)

    render conn, "show.html", product: product,
                              previous_product: Front.previous_product(product),
                              next_product: Front.next_product(product),
                              related_products: Front.get_related_products(product.id)
  end

  def index(conn, _params) do
    products = Front.list_products()

    render conn, "index.html", products: products
  end
end
