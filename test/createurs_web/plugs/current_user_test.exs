defmodule ShopixWeb.Plug.CurrentUserTest do
  use ShopixWeb.ConnCase, async: true
  alias ShopixWeb.Plug.CurrentUser

  test "call/2 when no user is logged sets current_user to nil" do
    conn = build_conn()
           |> CurrentUser.call(%{})

    assert conn.assigns.current_user == nil
  end

  test "call/2 when a user is logged sets the current_user" do
    user = insert(:user)
    conn = guardian_login(user)
           |> bypass_through(ShopixWeb.Router, [:browser, :admin_auth])
           |> get("/")
           |> CurrentUser.call(%{})

    assert conn.assigns.current_user.id == user.id
  end
end
