defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    base = String.downcase(base)
    sorted_base = sort(base)

    candidates
    |> Enum.filter(fn c ->
      c = String.downcase(c)
      c != base && sort(c) == sorted_base
    end)
  end

  defp sort(s) do
    s |> String.to_charlist() |> Enum.sort() |> List.to_string()
  end
end
