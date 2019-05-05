defmodule ShopixWeb.Plug.LocaleTest do
  use ShopixWeb.ConnCase, async: true
  alias ShopixWeb.Plug.Locale

  test "call/2 with no locale in conn sets default locale" do
    conn =
      build_conn()
      |> Plug.Conn.assign(:global_config, %{default_locale: "en", available_locales: ["en", "fr"]})
      |> Locale.call(%{})

    assert conn.status != 302
    assert conn.assigns[:current_locale] == "en"
  end

  test "call/2 with valid locale specified in conn sets the locale" do
    conn =
      build_conn(:get, "/", %{"locale" => "fr"})
      |> Plug.Conn.assign(:global_config, %{available_locales: ["en", "fr"]})
      |> Locale.call(%{})

    assert conn.status != 302
    assert conn.assigns[:current_locale] == "fr"
  end

  test "call/2 with invalid locale specified in conn redirects" do
    conn =
      build_conn(:get, "/", %{"locale" => "es"})
      |> Plug.Conn.assign(:global_config, %{available_locales: ["en", "fr"]})
      |> Locale.call(%{})

    assert conn.status == 302
  end
end
