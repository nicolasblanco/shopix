defmodule ShopixWeb.Plug.CurrentOrderTest do
  use ShopixWeb.ConnCase, async: true
  alias ShopixWeb.Plug.CurrentOrder
  alias Shopix.Schema.GlobalConfig

  test "call/2 when there is no current order sets nil" do
    conn =
      build_conn()
      |> bypass_through(ShopixWeb.Router, [:browser])
      |> assign(:global_config, %GlobalConfig{})
      |> get("/")
      |> CurrentOrder.call(%{})

    assert conn.assigns.current_order == nil
  end

  test "call/2 when there is a current order sets the current_order" do
    order = insert(:order)

    conn =
      build_conn()
      |> bypass_through(ShopixWeb.Router, [:browser])
      |> assign(:global_config, %GlobalConfig{})
      |> get("/")
      |> put_session(:order_id, order.id)
      |> CurrentOrder.call(%{})

    assert conn.assigns.current_order.id == order.id
  end
end
