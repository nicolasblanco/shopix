defmodule ShopixWeb.Admin.OrderControllerTest do
  use ShopixWeb.ConnCase, async: true

  test "index/2 responds with the orders" do
    insert(:order, email: "nicolas@nicolasblanco.fr")

    conn =
      guardian_login(insert(:user))
      |> get(admin_order_path(build_conn(), :index))

    assert html_response(conn, 200)
    assert conn.resp_body =~ "nicolas@nicolasblanco.fr"
  end

  test "show/2 responds with the order" do
    order = insert(:order, email: "nicolas@nicolasblanco.fr")

    conn =
      guardian_login(insert(:user))
      |> get(admin_order_path(build_conn(), :show, order.id))

    assert html_response(conn, 200)
    assert conn.resp_body =~ "nicolas@nicolasblanco.fr"
  end
end
