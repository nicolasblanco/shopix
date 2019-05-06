defmodule ShopixWeb.Plug.CurrentUser do
  import Plug.Conn

  alias Shopix.Guardian

  def init(opts), do: opts

  def call(conn, _opts) do
    current_user = Guardian.Plug.current_resource(conn, key: :admin)

    conn
    |> assign(:current_user, current_user)
  end
end
