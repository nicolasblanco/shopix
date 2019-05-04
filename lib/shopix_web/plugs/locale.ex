defmodule ShopixWeb.Plug.Locale do
  import Plug.Conn

  def init(opts), do: opts

  def call(%Plug.Conn{params: %{"locale" => locale},
                      assigns: %{global_config: %{available_locales: available_locales}}} = conn,
           _opts) do
    if locale in available_locales do
      conn
      |> assign(:current_locale, locale)
    else
      conn
      |> Phoenix.Controller.redirect(to: "/")
      |> halt()
    end
  end
  def call(%Plug.Conn{assigns: %{global_config: %{default_locale: default_locale}}} = conn, _opts) do
    conn
    |> assign(:current_locale, default_locale)
  end
end
