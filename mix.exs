defmodule Etymbot.Mixfile do
  use Mix.Project

  def project do
    [
      app: :etymbot,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Etymbot.Application, [:cowboy, :plug, :poison, :httpoison]}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 0.13"},
      {:cowboy, "~> 1.0.4"},
      {:plug, "~> 1.1.0"},
      {:poison, "~> 1.4.0"}
    ]
  end
end
