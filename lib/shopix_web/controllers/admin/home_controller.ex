defmodule ShopixWeb.Admin.HomeController do
  use ShopixWeb, :controller

  def index(conn, %{"locale" => locale}) do
    conn
    |> put_session(:admin_current_locale, locale)
    |> redirect(to: admin_home_path(conn, :index))
  end
  def index(conn, _params) do
    render conn, "index.html"
  end
end
