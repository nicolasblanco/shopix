use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :shopix, ShopixWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :shopix,
  shipping_cost_amount: "1000",
  uploadcare_public_key: "27420379b7cb39142873",
  create_translations_on_front: false

if System.get_env("DATABASE_POSTGRESQL_USERNAME") do
  # Configure your database
  config :shopix, Shopix.Repo,
    adapter: Ecto.Adapters.Postgres,
    database: "shopix_test",
    hostname: "localhost",
    username: System.get_env("DATABASE_POSTGRESQL_USERNAME"),
    password: System.get_env("DATABASE_POSTGRESQL_PASSWORD"),
    pool: Ecto.Adapters.SQL.Sandbox
else
  # Configure your database
  config :shopix, Shopix.Repo,
    adapter: Ecto.Adapters.Postgres,
    database: "shopix_test",
    hostname: "localhost",
    pool: Ecto.Adapters.SQL.Sandbox
end

config :bcrypt_elixir, :log_rounds, 4

config :shopix, Shopix.Mailer,
  adapter: Bamboo.TestAdapter
