defmodule MakeupTs.LexerTest do
  use ExUnit.Case

  import MakeupTS.Testing, only: [lex: 1]

  test "whitespace" do
    assert lex("   ") == [{:whitespace, %{}, "   "}]
  end

  test "single line comment" do
    assert lex("// comment") == [
             {:comment_single, %{}, "// comment"}
           ]
  end

  test "multi line comment" do
    assert lex("""
           /*
           comment
           /*
           """) == [
             {:operator, %{}, "/"},
             {:operator, %{}, "*"},
             {:whitespace, %{}, "\n"},
             {:name, %{}, "comment"},
             {:whitespace, %{}, "\n"},
             {:operator, %{}, "/"},
             {:operator, %{}, "*"},
             {:whitespace, %{}, "\n"}
           ]
  end

  test "integers" do
    assert lex("10") == [{:number_integer, %{}, "10"}]
    assert lex("1_000") == [{:number_integer, %{}, "1_000"}]
    assert lex("0888") == [{:number_integer, %{}, "0888"}]
    assert lex("0777") == [{:number_integer, %{}, "0777"}]
  end

  test "floats" do
    assert lex("1.440") == [{:number_float, %{}, "1.440"}]

    assert lex("1_050.95") == [
             {:number_float, %{}, "1_050.95"}
           ]
  end

  test "keywords" do
    assert lex("new Array") == [
             {:operator_word, %{}, "new"},
             {:whitespace, %{}, " "},
             {:name_builtin, %{}, "Array"}
           ]

    assert lex("const a = 0") == [
             {:keyword_declaration, %{}, "const"},
             {:whitespace, %{}, " "},
             {:name, %{}, "a"},
             {:whitespace, %{}, " "},
             {:operator, %{}, "="},
             {:whitespace, %{}, " "},
             {:number_integer, %{}, "0"}
           ]
  end

  test "works" do
    assert lex("""
           const foo: Foo

           const bar = () => undefined

           function baz (param: number): number {
            return param + 5;
           }


           """)
  end

  test "lexes class with constructor" do
    assert [
             {:keyword_declaration, %{}, "class"},
             {:whitespace, %{}, " "},
             {:keyword_type, %{}, "SomeClass"},
             {:whitespace, %{}, " "},
             {:punctuation, %{group_id: curly}, "{"},
             {:whitespace, %{}, "\n "},
             {:name_function, %{}, "constructor"},
             {:punctuation, %{group_id: parens}, "("},
             {:punctuation, %{group_id: parens}, ")"},
             {:whitespace, %{}, " "},
             {:punctuation, %{group_id: curly_2}, "{"},
             {:whitespace, %{}, "\n   "},
             {:keyword_reserved, %{}, "this"},
             {:punctuation, %{}, "."},
             {:name, %{}, "foo"},
             {:whitespace, %{}, " "},
             {:operator, %{}, "="},
             {:whitespace, %{}, " "},
             {:string, %{}, ~s("bar")},
             {:punctuation, %{}, ";"},
             {:whitespace, %{}, "\n "},
             {:punctuation, %{group_id: curly_2}, "}"},
             {:whitespace, %{}, "\n"},
             {:punctuation, %{group_id: curly}, "}"},
             {:whitespace, %{}, "\n"}
           ] =
             lex("""
             class SomeClass {
              constructor() {
                this.foo = "bar";
              }
             }
             """)
  end

  test "lexes types in extends statement" do
    assert lex("T extends number") == [
      {:keyword_type, %{}, "T"},
      {:whitespace, %{}, " "},
      {:keyword_reserved, %{}, "extends"},
      {:whitespace, %{}, " "},
      {:keyword_type, %{}, "number"}
    ]

    assert lex("T extends () => void") == [
             {:keyword_type, %{}, "T"},
             {:whitespace, %{}, " "},
             {:keyword_reserved, %{}, "extends"},
             {:whitespace, %{}, " "},
             {:punctuation, %{group_id: "group-1"}, "("},
             {:punctuation, %{group_id: "group-1"}, ")"},
             {:whitespace, %{}, " "},
             {:operator, %{}, "=>"},
             {:whitespace, %{}, " "},
             {:operator_word, %{}, "void"}
           ]

    assert lex("T extends 1") == [
             {:keyword_type, %{}, "T"},
             {:whitespace, %{}, " "},
             {:keyword_reserved, %{}, "extends"},
             {:whitespace, %{}, " "},
             {:number_integer, %{}, "1"}
           ]
  end
end
