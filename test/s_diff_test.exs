defmodule SDiffTest do
  use ExUnit.Case
  doctest SDiff

  test "getting difference by default diff options" do
    assert SDiff.diff("a", "b") == [del: "a", ins: "b"]
  end

  test "getting difference by char options" do
    assert SDiff.diff_char("a", "b") == [del: "a", ins: "b"]
  end

  test "getting difference by word options" do
    assert SDiff.diff_word("a b", "a cc") == [eq: "a ", del: "b", ins: "cc"]
  end

  test "getting unicode string difference by word options" do
    assert SDiff.diff_word("hi ücen", "hello üceneee") == [
             del: "hi",
             ins: "hello",
             eq: " ",
             del: "ücen",
             ins: "üceneee"
           ]
  end

  test "getting difference by line options" do
    assert SDiff.diff_line("a \n bb", "a \n cc") == [eq: "a \n ", del: "bb", ins: "cc"]
  end
end
