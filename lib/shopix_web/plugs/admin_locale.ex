defmodule ShopixWeb.Plug.AdminLocale do
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    locale = get_session(conn, :admin_current_locale) || "en"
    Gettext.put_locale ShopixWeb.Gettext, locale

    conn
    |> assign(:admin_current_locale, locale)
  end
end
