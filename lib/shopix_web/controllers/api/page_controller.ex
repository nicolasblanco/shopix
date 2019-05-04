defmodule ShopixWeb.Api.PageController do
  use ShopixWeb, :controller
  alias Shopix.Front

  def show(conn, %{"id" => id}) do
    locale = conn.assigns.current_locale
    page = Front.get_page_by_slug!(id, locale)

    render conn, "show.json", page: page, locale: locale
  end
end
