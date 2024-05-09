defmodule KillerSudokuHelper do
  @doc """
  Return the possible combinations of `size` distinct numbers from 1-9 excluding `exclude` that sum up to `sum`.
  """
  @spec combinations(cage :: %{exclude: [integer], size: integer, sum: integer}) :: [[integer]]
  def combinations(%{exclude: exclude, size: size, sum: sum}) do
    1..9
    |> Enum.filter(fn n -> n not in exclude end)
    |> combo(size)
    |> Enum.filter(fn lst -> Enum.sum(lst) == sum end)
  end

  defp combo(_, 0), do: [[]]
  defp combo([], _), do: []
  defp combo([h | t], n) do
    for(l <- combo(t, n - 1), do: [h | l]) ++ combo(t, n)
  end
end

