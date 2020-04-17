defmodule SDiff do
  @moduledoc """
  Documentation for `SDiff`.
  """

  @word_regex ~r/(^\s+|[()[\]{}'"]|\b)/
  @line_regex ~r/(\n|\r\n)/
  @doc """
  string diff with myers_difference.

  ## Examples

      iex> SDiff.diff("a", "b")
      [del: "a", ins: "b"]

  """
  def diff(string1, string2), do: diff(string1, string2, :char)

  @doc """
  string diff with myers_difference. (Default options)

  ## Examples

      iex> SDiff.diff("a", "b", :char)
      [del: "a", ins: "b"]

  """
  def diff(string1, string2, :char) do
    String.myers_difference(string1, string2)
  end

  @doc """
  string diff by words

  ## Examples

      iex> SDiff.diff("aa bb", "aa cc", :word)
      [eq: ["aa", " "], del: ["bb"], ins: ["cc"]]

  """
  def diff(string1, string2, :word) do
    string1
    |> String.split(@word_regex)
    |> remove_empty
    |> List.myers_difference(
      string2
      |> String.split(@word_regex)
      |> remove_empty
    )
    |> Enum.map(fn {kind, chars} -> {kind, IO.iodata_to_binary(chars)} end)
  end

  @doc """
  string diff by lines

  ## Examples

      iex> SDiff.diff("aa bb", "aa cc", :line)
      [del: "aa bb", ins: "aa cc"]

  """
  def diff(string1, string2, :line) do
    string1
    |> String.split(@line_regex)
    |> remove_empty
    |> List.myers_difference(
      string2
      |> String.split(@line_regex)
      |> remove_empty
    )
    |> Enum.map(fn {kind, chars} -> {kind, IO.iodata_to_binary(chars)} end)
  end

  defp remove_empty(string_list) do
    string_list
    |> Enum.filter(&(String.length(&1) > 0))
  end
end
