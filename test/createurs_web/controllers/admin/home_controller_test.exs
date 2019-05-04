defmodule ShopixWeb.Admin.HomeControllerTest do
  use ShopixWeb.ConnCase, async: true

  test "index/2 responds with the dashboard" do
    conn = guardian_login(insert(:user))
           |> get(admin_home_path(build_conn(), :index))

    assert html_response(conn, 200)
    assert conn.resp_body =~ "Dashboard"
  end
end
