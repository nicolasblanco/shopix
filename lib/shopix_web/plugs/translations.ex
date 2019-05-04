defmodule ShopixWeb.Plug.Translations do
  alias Shopix.Front
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    translation_key = "#{controller_key(conn)}.#{action_key(conn)}"

    conn
    |> assign(:translations, Front.get_translations(translation_key))
    |> assign(:translation_key, translation_key)
  end

  defp action_key(conn) do
    conn
    |> Phoenix.Controller.action_name()
    |> to_string
  end

  defp controller_key(conn) do
    controller_keys = conn
                      |> Phoenix.Controller.controller_module()
                      |> to_string |> String.split(".") |> Enum.slice(-2..-1)
    controller_prefix = controller_keys |> Enum.at(0)
    controller_suffix = controller_keys |> Enum.at(1) |> String.replace("Controller", "")

    "#{controller_prefix}.#{controller_suffix}" |> String.downcase
  end
end
