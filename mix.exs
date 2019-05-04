defmodule DavosCharityApi.MixProject do
  use Mix.Project

  def project do
    [
      app: :davos_charity_api,
      version: "0.1.10",
      elixir: "~> 1.8.1",
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
    [
      mod: {DavosCharityApi.Application, []},
      extra_applications: [:logger, :runtime_tools, :pdf_generator]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.4.0"},
      {:phoenix_pubsub, "~> 1.1"},
      {:phoenix_ecto, "~> 4.0"},
      {:ecto, "~> 3.0.3", override: true},
      {:ecto_sql, "~> 3.0-rc", override: true},
      {:postgrex, ">= 0.0.0-rc"},
      {:phoenix_html, "~> 2.11"},
      {:phoenix_live_reload, "~> 1.2-rc", only: :dev},
      {:gettext, "~> 0.11"},
      {:jason, "~> 1.0"},
      {:plug_cowboy, "~> 2.0"},
      {:ja_serializer, github: "vt-elixir/ja_serializer"},
      {:cors_plug, "~> 1.2"},
      {:comeonin, "~>4.0"},
      {:bcrypt_elixir, "~> 1.0"},
      {:joken, "~> 1.5.0"},
      {:number, "~> 0.5.7"},
      {:react_phoenix, github: "geolessel/react-phoenix", branch: "webpack"},
      {:poison, "~> 4.0.1", override: true},
      {:timex, "~> 3.1"},
      {:edeliver, ">= 1.6.0"},
      {:distillery, "~> 2.0", warn_missing: false},
      {:exiats, path: "/Users/ian_knauer/programming/davos/exiats"},
      {:decimal, "~> 1.0"},
      {:bamboo, "~> 1.2"},
      {:pdf_generator, "~> 0.5.2"},
      {:export, "~> 0.1.0"}
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
