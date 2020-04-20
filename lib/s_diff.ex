defmodule SDiff do
  @moduledoc """
  Documentation for `SDiff`.
  """

  @word_regex ~r/(^\s+|[()[]{}'"]|\b)/u
  @line_regex ~r/(^\n|\r\n|\b)/
  @doc """
  string diff with myers_difference.

  ## Examples

      iex> SDiff.diff("a", "b")
      [del: "a", ins: "b"]

  """
  def diff(string1, string2), do: diff_char(string1, string2)

  @doc """
  string diff with myers_difference. (Default options)

  ## Examples

      iex> SDiff.diff_char("a", "b")
      [del: "a", ins: "b"]

  """
  def diff_char(string1, string2) do
    String.myers_difference(string1, string2)
  end

  @doc """
  string diff by words

  ## Examples

      iex> SDiff.diff_word("aa bb", "aa cc")
      [eq: "aa ", del: "bb", ins: "cc"]

  """
  def diff_word(string1, string2) do
    string1
    |> String.split(@word_regex)
    |> remove_empty
    |> List.myers_difference(
      string2
      |> String.split(@word_regex)
      |> remove_empty
    )
    |> Enum.map(fn {kind, string} -> {kind, IO.iodata_to_binary(string)} end)
  end

  @doc """
  string diff by lines

  ## Examples

      iex> SDiff.diff_line("aa bb", "aa cc")
      [eq: "aa ", del: "bb", ins: "cc"]

  """
  def diff_line(string1, string2) do
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
