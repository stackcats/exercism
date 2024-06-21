defmodule Knapsack do
  @doc """
  Return the maximum value that a knapsack can carry.
  """
  @spec maximum_value(items :: [%{value: integer, weight: integer}], maximum_weight :: integer) ::
          integer
  def maximum_value(items, maximum_weight) do
    items
    |> Enum.reduce(%{}, fn %{value: value, weight: weight}, acc ->
      maximum_weight..weight//-1
      |> Enum.reduce(acc, fn w, acc ->
        v = max((acc[w - weight] || 0) + value, acc[w] || 0)
        Map.put(acc, w, v)
      end)
    end)
    |> Map.get(maximum_weight, 0)
  end
end
