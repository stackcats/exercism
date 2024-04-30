defmodule Change do
  @doc """
    Determine the least number of coins to be given to the user such
    that the sum of the coins' value would equal the correct amount of change.
    It returns {:error, "cannot change"} if it is not possible to compute the
    right amount of coins. Otherwise returns the tuple {:ok, list_of_coins}

    ## Examples

      iex> Change.generate([5, 10, 15], 3)
      {:error, "cannot change"}

      iex> Change.generate([1, 5, 10], 18)
      {:ok, [1, 1, 1, 5, 10]}

  """

  @spec generate(list, integer) :: {:ok, list} | {:error, String.t()}
  def generate(_, target) when target < 0, do: {:error, "cannot change"}
  def generate(_, 0), do: {:ok, []}
  def generate(coins, target) do
    coins
    |> Enum.reduce({%{0 => 0}, %{}}, fn coin, acc ->
      1..target
      |> Enum.reduce(acc, fn amount, {dp, changes} ->
        if Map.get(dp, amount - coin, target + 1) + 1 < Map.get(dp, amount, target + 1) do
          dp = Map.put(dp, amount, dp[amount - coin] + 1)
          cs = Map.get(changes, amount - coin, [])
          changes = Map.put(changes, amount, [coin|cs])
          {dp, changes}
        else
          {dp, changes}
        end
      end)
    end)
    |> elem(1)
    |> then(fn changes ->
      case changes[target] do
        nil -> {:error, "cannot change"}
        cs -> {:ok, Enum.sort(cs)}
      end
    end)
  end
end

