defmodule RomanNumerals do
  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number) do
    letters = [~w(I V X), ~w(X L C), ~w(C D M), ~w(M M M)]
    aux(number, letters, [])
  end

  defp aux(0, _, ans) do
    ans |> Enum.join()
  end

  defp aux(n, [[l, v, x] | ls], ans) do
    d = rem(n, 10)

    ans =
      cond do
        d == 0 ->
          ans

        d in 1..3 ->
          [String.duplicate(l, d) | ans]

        d == 4 ->
          [l <> v | ans]

        d == 5 ->
          [v | ans]

        d in 6..8 ->
          [v <> String.duplicate(l, d - 5) | ans]

        9 ->
          [l <> x | ans]
      end

    aux(div(n, 10), ls, ans)
  end
end
