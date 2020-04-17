defmodule SDiffTest do
  use ExUnit.Case
  doctest SDiff

  test "getting difference by default diff options" do
    assert SDiff.diff("a", "b") == [del: "a", ins: "b"]
  end

  test "getting difference by char options" do
    assert SDiff.diff("a", "b", :char) == [del: "a", ins: "b"]
  end

  test "getting difference by word options" do
    assert SDiff.diff("a b", "a cc", :word) == [eq: "a ", del: "b", ins: "cc"]
  end

  test "getting difference by line options" do
    assert SDiff.diff("a \n bb", "a \n cc", :word) == [eq: "a \n ", del: "bb", ins: "cc"]
  end
end
