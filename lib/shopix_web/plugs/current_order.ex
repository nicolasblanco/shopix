defmodule ShopixWeb.Plug.CurrentOrder do
  import Plug.Conn
  alias Shopix.Front

  def init(opts), do: opts

  def call(%{assigns: %{global_config: global_config}} = conn, _opts) do
    case get_session(conn, :order_id) do
      nil -> assign(conn, :current_order, nil)
      order_id -> assign(conn, :current_order, Front.get_order(order_id, global_config))
    end
  end
end
