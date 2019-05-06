defmodule ShopixWeb.Front.HomeController do
  use ShopixWeb, :controller
  alias Shopix.Front
  import ShopixWeb.TranslationHelpers

  plug ShopixWeb.Plug.Translations

  def index(%{assigns: %{global_config: %{shop_opened: true}}} = conn, _params) do
    render(conn, "index.html")
  end

  def index(conn, _params) do
    conn |> put_status(:not_found) |> render(ShopixWeb.ErrorView, "404.html", layout: false)
  end

  def shop(conn, _params) do
    product = Front.first_product()

    conn
    |> redirect(
      to:
        product_path(
          conn,
          :show,
          conn.assigns.current_locale,
          t_slug(product, conn.assigns.current_locale)
        )
    )
  end
end
