defmodule Minter.MixProject do
  use Mix.Project

  def project do
    [
      app: :minter,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :grpc],
      mod: {MinterApp, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:grpc, github: "tony612/grpc-elixir"},
      {:google_protos, "~> 0.1"},
      {:gun, "1.0.0-pre.5", override: true},
      {:ecto, "~> 2.0"},
      {:postgrex, "~> 0.11"},
      {:mix_test_watch, "~> 0.6", only: :dev, runtime: false},
      {:dialyxir, "~> 0.4", only: [:dev]}
    ]
  end
end
