defmodule Sieve do
  @doc """
  Generates a list of primes up to a given limit.
  """
  @spec primes_to(non_neg_integer) :: [non_neg_integer]
  def primes_to(limit) when limit < 2, do: []
  def primes_to(limit) do
    st = MapSet.new(2..limit)
    2..limit
    |> Enum.reduce(st, fn n, acc ->
      if MapSet.member?(acc, n) do
        (n+n)..limit//n
        |> Enum.reduce(acc, fn x, acc -> MapSet.delete(acc, x) end)
      else
        acc
      end
    end)
    |> Enum.sort()
  end
end

