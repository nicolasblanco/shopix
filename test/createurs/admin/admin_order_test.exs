defmodule Shopix.Admin.AdminOrderTest do
  use Shopix.DataCase, async: true

  alias Shopix.Admin

  test "list_orders/1 returns all orders completed paginated" do
    order = insert(:order)

    assert %{entries: orders} = Admin.list_orders(%{})
    assert Enum.count(orders) == 1
    assert (orders |> Enum.at(0)).id == order.id
  end

  test "get_order!/1 returns the order with given id" do
    order = insert(:order)
    order_get = Admin.get_order!(order.id)
    assert order_get.id == order.id
  end
end
