defmodule MakeupTS.RegistryTest do
  use ExUnit.Case, async: true

  alias Makeup.Registry
  alias MakeupTS.Lexer

  describe "the Js lexer has successfully registered itself:" do
    test "language name" do
      assert {:ok, {Lexer, []}} == Registry.fetch_lexer_by_name("js")
      assert {:ok, {Lexer, []}} == Registry.fetch_lexer_by_name("javascript")
    end

    test "file extension" do
      assert {:ok, {Lexer, []}} == Registry.fetch_lexer_by_extension("js")
    end
  end
end
