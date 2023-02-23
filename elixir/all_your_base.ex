defmodule AllYourBase do
  @doc """
  Given a number in input base, represented as a sequence of digits, converts it to output base,
  or returns an error tuple if either of the bases are less than 2
  """
  @spec convert(list, integer, integer) :: {:ok, list} | {:error, String.t()}
  def convert(digits, input_base, output_base) do
    cond do
      output_base < 2 ->
        {:error, "output base must be >= 2"}

      input_base < 2 ->
        {:error, "input base must be >= 2"}

      Enum.any?(digits, &(&1 < 0 || &1 >= input_base)) ->
        {:error, "all digits must be >= 0 and < input base"}

      true ->
        digits
        |> Enum.reduce(0, fn d, acc ->
          acc * input_base + d
        end)
        |> aux(output_base, [])
    end
  end

  defp aux(0, _, []), do: {:ok, [0]}
  defp aux(0, _, lst), do: {:ok, lst}

  defp aux(n, base, lst) do
    aux(div(n, base), base, [rem(n, base) | lst])
  end
end
