defmodule PalindromeProducts do
  @doc """
  Generates all palindrome products from an optionally given min factor (or 1) to a given max factor.
  """
  @spec generate(non_neg_integer, non_neg_integer) :: map
  def generate(max_factor, min_factor \\ 1)

  def generate(max_factor, min_factor) when max_factor < min_factor do
    raise ArgumentError
  end

  def generate(max_factor, min_factor) do
    for i <- min_factor..max_factor, j <- i..max_factor, reduce: %{} do
      acc ->
        n = i * j

        if palindrome?(n) do
          Map.update(acc, n, [[i, j]], &[[i, j] | &1])
        else
          acc
        end
    end
  end

  defp palindrome?(n) do
    s = "#{n}"
    s == String.reverse(s)
  end
end
