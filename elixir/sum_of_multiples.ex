defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.
  """
  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer
  def to(limit, factors) do
    factors
    |> Stream.filter(&(&1 != 0))
    |> Enum.reduce(%MapSet{}, fn n, acc ->
      n..(limit - 1)//n
      |> Enum.reduce(acc, fn each, acc ->
        MapSet.put(acc, each)
      end)
    end)
    |> Enum.sum()
  end
end
