defmodule ShopixWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :shopix

  socket "/socket", ShopixWeb.UserSocket,
    websocket: true # or list of options

  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phoenix.digest
  # when deploying your static files in production.
  plug Plug.Static,
    at: "/",
    from: :shopix,
    gzip: false,
    only: ~w(css fonts images js favicon.ico robots.txt img video)

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    socket "/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
  end

  plug Plug.RequestId
  plug Plug.Logger

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Jason

  plug Plug.MethodOverride
  plug Plug.Head

  # The session will be stored in the cookie and signed,
  # this means its contents can be read but not tampered with.
  # Set :encryption_salt if you would also like to encrypt it.
  plug Plug.Session,
    store: :cookie,
    key: "_shopix_key",
    signing_salt: "1LcaTYG2",
    encryption_salt: "aAXS92gwFbGOZsbk+hUxSiOdfb8PbFsK7Liv6WklmH+L5y7mKIBmsVOrH/JjxBIy"

  plug CORSPlug, origin: ~r/https?.*$/

  plug ShopixWeb.Router

  @doc """
  Callback invoked for dynamically configuring the endpoint.

  It receives the endpoint configuration and checks if
  configuration should be loaded from the system environment.
  """
  def init(_key, config) do
    if config[:load_from_system_env] do
      port = System.get_env("PORT") || raise "expected the PORT environment variable to be set"
      {:ok, Keyword.put(config, :http, [:inet6, port: port])}
    else
      {:ok, config}
    end
  end
end
