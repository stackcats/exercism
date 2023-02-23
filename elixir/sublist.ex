defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) do
    cond do
      a === b -> :equal
      contain(a, b) -> :superlist
      contain(b, a) -> :sublist
      true -> :unequal
    end
  end

  defp contain(_, []), do: true

  defp contain(a, b) do
    Stream.chunk_every(a, length(b), 1, :discard)
    |> Enum.any?(&(&1 === b))
  end
end
