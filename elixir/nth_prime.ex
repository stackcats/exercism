defmodule Prime do
  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(count) when count < 1 do
    raise "there is no zeroth prime"
  end

  def nth(count) do
    aux(2, count)
  end

  @spec aux(non_neg_integer(), non_neg_integer()) :: non_neg_integer()
  defp aux(n, count) do
    if prime?(n) do
      count = count - 1

      if count == 0 do
        n
      else
        aux(n + 1, count)
      end
    else
      aux(n + 1, count)
    end
  end

  @spec prime?(non_neg_integer()) :: boolean()
  defp prime?(n) when n < 2, do: false
  defp prime?(2), do: true

  defp prime?(n) do
    2..round(n ** 0.5)
    |> Enum.all?(fn x -> rem(n, x) != 0 end)
  end
end
