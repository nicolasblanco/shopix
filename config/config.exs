# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :shopix,
  ecto_repos: [Shopix.Repo]

# Configures the endpoint
config :shopix, ShopixWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "sHmXxj8axfw3vqu2I9T3IUXv5wVZ4SkanrrwiVFy7Gao7sw++jqT9CbLbE3T8fPz",
  render_errors: [view: ShopixWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Shopix.PubSub, adapter: Phoenix.PubSub.PG2]

config :shopix,
  create_translations_on_front: true

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :template_engines,
  slim: PhoenixSlime.Engine,
  slime: PhoenixSlime.Engine

config :shopix, Shopix.Guardian,
  issuer: "shopix",
  secret_key: "2PsWyRBou2HTTI6iPoLm0YOuwlA0W8iEBn8/Uo1rvIuT7de9OGp9VE7a0YLra8Kw"

config :money,
  default_currency: :EUR,
  separator: " ",
  delimeter: ",",
  symbol: true,
  symbol_on_right: true,
  symbol_space: true

config :scrivener_html,
  routes_helper: ShopixWeb.Router.Helpers,
  # If you use a single view style everywhere, you can configure it here. See View Styles below for more info.
  view_style: :bootstrap_v4

config :sentry,
  dsn: System.get_env("SENTRY_DSN"),
  enable_source_code_context: true,
  root_source_code_path: File.cwd!(),
  included_environments: ~w(production staging),
  environment_name: System.get_env("RELEASE_LEVEL") || "development"

config :braintree,
  environment: :foo,
  merchant_id: "foobar",
  public_key: "foobar",
  private_key: "foobar"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
