defmodule ShopixWeb.Front.PageController do
  use ShopixWeb, :controller
  alias Shopix.Front

  plug(ShopixWeb.Plug.Translations)

  def show(conn, %{"id" => id}) do
    page = Front.get_page_by_slug!(id, conn.assigns.current_locale)

    template =
      case page.key do
        "contact" -> "contact.html"
        _ -> "show.html"
      end

    render(conn, template, page: page)
  end
end
