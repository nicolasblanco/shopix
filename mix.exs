defmodule Shopix.Mixfile do
  use Mix.Project

  def project do
    [
      app: :shopix,
      version: "0.0.1",
      elixir: "~> 1.4",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {Shopix.Application, []}, extra_applications: [:logger, :runtime_tools, :bamboo]]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.3.0"},
      {:phoenix_pubsub, "~> 1.0"},
      {:phoenix_ecto, "~> 3.2"},
      {:postgrex, ">= 0.0.0"},
      {:phoenix_html, "~> 2.6"},
      {:phoenix_live_reload, "~> 1.0", only: :dev},
      {:gettext, "~> 0.11"},
      {:phoenix_slime, github: "slime-lang/phoenix_slime"},
      {:slugger, "~> 0.2"},
      {:comeonin, "~> 4.0"},
      {:bcrypt_elixir, "~> 1.0"},
      {:guardian, "~> 1.2"},
      {:money, "~> 1.4.0"},
      {:braintree, "~> 0.8"},
      {:bamboo, "~> 1.1"},
      {:yaml_elixir, "~> 2.1"},
      {:decimal, "~> 1.0"},
      {:ex_machina, "~> 2.0"},
      {:credo, "~> 0.8", only: [:dev, :test], runtime: false},
      {:jason, "~> 1.1"},
      {:sentry, "~> 7.0"},
      {:timex, "~> 3.1"},
      {:timex_ecto, "~> 3.1"},
      {:bootform, github: "Grafikart/elixir-bootform"},
      {:scrivener_ecto, "~> 1.0"},
      {:scrivener_html, "~> 1.7"},
      {:deferred_config, "~> 0.1.0"},
      {:liquid, "~> 0.9.1"},
      {:cors_plug, "~> 1.2"},
      {:plug_cowboy, "~> 1.0"},
      {:dialyxir, "~> 0.5", only: [:dev], runtime: false}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end
