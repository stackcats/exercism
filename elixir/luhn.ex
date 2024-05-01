defmodule Luhn do
  @doc """
  Checks if the given number is valid via the luhn formula
  """
  @spec valid?(String.t()) :: boolean
  def valid?(number) do
    n = String.replace(number, " ", "")
    len = String.length(n)

    if len < 2 do
      false
    else
      r = rem(len, 2)

      n
      |> String.graphemes()
      |> Enum.with_index()
      |> Enum.reduce_while(0, fn {c, i}, acc ->
        case Integer.parse(c) do
          {x, _} ->
            x = if rem(i, 2) == r, do: x * 2, else: x
            x = if x > 9, do: x - 9, else: x
            {:cont, acc + x}

          _ ->
            {:halt, 1}
        end
      end)
      |> then(fn acc -> rem(acc, 10) == 0 end)
    end
  end
end

