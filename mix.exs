defmodule Masker.MixProject do
  use Mix.Project

  def project do
    [
      app: :masker,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      name: "Masker",
      description: "Tool for finding a 2d pattern in a 2d list.",
      package: [
        licenses: ["MIT"],
        links: %{"GitHub" => "https://github.com/aadonskoy/masker"}
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end
end
