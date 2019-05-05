defmodule ShopixWeb.Plug.GlobalConfig do
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    global_config = Shopix.Schema.GlobalConfig |> Ecto.Query.first() |> Shopix.Repo.one!()

    conn
    |> assign(:global_config, global_config)
  end
end
