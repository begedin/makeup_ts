# MakeupTs

## [![Hex pm](http://img.shields.io/hexpm/v/makeup_ts.svg?style=flat)](https://hex.pm/packages/makeup_ts) [![Hex Docs](https://img.shields.io/badge/hex-docs-9768d1.svg)](https://hexdocs.pm/makeup_ts) [![License](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)![.github/workflows/elixir.yml](https://github.com/begedin/makeup_ts/workflows/.github/workflows/elixir.yml/badge.svg)

<!-- MDOC !-->

A `Makeup` lexer for Typescript(and javascript).

It's incomplete as of yet and could be expanded to Typescript and jsx/tsx.

## Installation

The package can be installed
by adding `makeup_ts` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:makeup_ts, "~> 0.1.0"}
  ]
end
```
The lexer will be automatically registered in Makeup for the languages "javascript" as well as the extensions ".js" and ".javascript".
