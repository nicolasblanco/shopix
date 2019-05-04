defmodule ShopixWeb.TranslationHelpersTest do
  use ShopixWeb.ConnCase, async: true
  alias ShopixWeb.TranslationHelpers

  test "t_field/3 returns the translation of a field which has been translated" do
    data = %{value_translations: %{"en" => "foo bar", "fr" => "not"}}

    assert TranslationHelpers.t_field(data, :value, "en") =~ "foo bar"
  end

  test "t_field/3 returns an empty string of a field which has not been translated" do
    assert TranslationHelpers.t_field(%{value_translations: nil}, :value, "en") == ""
    assert TranslationHelpers.t_field(%{value_translations: %{"en" => nil}}, :value, "en") == ""
  end

  test "root_path_unless_default_locale/2 returns the root path if passed locale is the default locale" do
    assert TranslationHelpers.root_path_unless_default_locale(%{assigns: %{global_config: %{default_locale: "en"}}}, "en") == "/"
  end

  test "root_path_unless_default_locale/2 returns the localized path if passed locale is not the default locale" do
    assert TranslationHelpers.root_path_unless_default_locale(%{assigns: %{global_config: %{default_locale: "en"}}}, "fr") == "/fr"
  end

  test "locales_filled_on/2 returns the locales which has been set" do
    data = %{value_translations: %{"en" => "foo bar", "fr" => ""}}
    assert TranslationHelpers.locales_filled_on(%{assigns: %{global_config: %{available_locales: ["en", "fr"]}}}, data, :value) == ["en"]
  end

  test "t_slug/2 returns the translated slug" do
    data = %{slug_translations: %{"en" => "the-great-foo-bar"}}
    assert TranslationHelpers.t_slug(data, "en") == "the-great-foo-bar"
  end

  test "t/2 returns the translation if it exists in the conn" do
    conn = build_conn()
           |> assign(:translations, [%{key: "front.layout.title", value_translations: %{"en" => "foobar"}}])
           |> assign(:current_locale, "en")

    assert TranslationHelpers.t(conn, "front.layout.title") == {:safe, "foobar"}
  end

  test "t/2 returns the key if it does not exist in the conn" do
    conn = build_conn()
           |> assign(:translations, [])
           |> assign(:current_locale, "en")

    assert TranslationHelpers.t(conn, "front.layout.title") == {:safe, "front.layout.title"}
  end

  test "t/2 returns a plain translation if option :plain is passed" do
    conn = build_conn()
           |> assign(:translations, [%{key: "front.layout.title", value_translations: %{"en" => "foobar"}}])
           |> assign(:current_locale, "en")

    assert TranslationHelpers.t(conn, "front.layout.title", plain: true) == "foobar"
  end
end
