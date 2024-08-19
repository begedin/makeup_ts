defmodule MakeupTs.Application do
  @moduledoc false
  use Application

  alias Makeup.Registry

  def start(_type, _args) do
    Registry.register_lexer(MakeupTS.Lexer,
      options: [],
      names: ["js", "javascript", "ts", "typescript"],
      extensions: ["js", "ts"]
    )

    Supervisor.start_link([], strategy: :one_for_one)
  end
end
