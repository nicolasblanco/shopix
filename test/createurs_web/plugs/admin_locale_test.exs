defmodule ShopixWeb.Plug.AdminLocaleTest do
  use ShopixWeb.ConnCase, async: true
  alias ShopixWeb.Plug.AdminLocale

  test "call/2 when there is no current admin locale sets default locale" do
    conn = build_conn()
           |> bypass_through(ShopixWeb.Router, [:browser])
           |> get("/")
           |> AdminLocale.call(%{})

    assert conn.assigns.admin_current_locale == "en"
  end

  test "call/2 when there is a current admin locale sets the admin locale" do
    conn = build_conn()
           |> bypass_through(ShopixWeb.Router, [:browser])
           |> get("/")
           |> put_session(:admin_current_locale, "fr")
           |> AdminLocale.call(%{})

    assert conn.assigns.admin_current_locale == "fr"
  end
end
