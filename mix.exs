defmodule MakeupTs.MixProject do
  use Mix.Project

  @version "0.2.1"

  @url "https://github.com/begedin/makeup_ts"
  def project do
    [
      app: :makeup_ts,
      version: @version,
      elixir: "~> 1.16",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      # Package
      package: package(),
      description: description(),
      aliases: aliases(),
      docs: docs()
    ]
  end

  defp aliases do
    [
      docs: &build_docs/1
    ]
  end

  defp description do
    """
    Typescript and Javascript lexer for the Makeup syntax highlighter.
    Forked from https://github.com/maartenvanvliet/makeup_js
    """
  end

  defp package do
    [
      maintainers: ["Nikola Begedin"],
      licenses: ["MIT"],
      links: %{"GitHub" => @url},
      files: ~w(LICENSE README.md lib mix.exs .formatter.exs)
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [],
      deps: deps(),
      mod: {MakeupTs.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:makeup, "~> 1.1"},
      {:ex_doc, "~> 0.34", only: :dev}
    ]
  end

  def docs do
    [
      extras: ["README.md"],
      source_ref: "v#{@version}",
      main: "MakeupTS.Lexer"
    ]
  end

  defp build_docs(_) do
    Mix.Task.run("compile")
    ex_doc = Path.join(Mix.path_for(:escripts), "ex_doc")

    unless File.exists?(ex_doc) do
      raise "cannot build docs because escript for ex_doc is not installed"
    end

    args = ["MakeupTs", @version, Mix.Project.compile_path()]
    opts = ~w[--main MakeupTS.Lexer --source-ref v#{@version} --source-url #{@url}]
    System.cmd(ex_doc, args ++ opts)
    Mix.shell().info("Docs built successfully")
  end
end
