defmodule ShopixWeb.Api.ShopController do
  use ShopixWeb, :controller

  def show(conn, _) do
    render(conn, "show.json", global_config: conn.assigns.global_config)
  end
end
