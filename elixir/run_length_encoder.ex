defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t()) :: String.t()
  def encode(string) do
    string
    |> String.graphemes()
    |> Enum.chunk_while(
      [],
      fn c, acc ->
        cond do
          acc == [] -> {:cont, [c]}
          hd(acc) == c -> {:cont, [c | acc]}
          true -> {:cont, acc, [c]}
        end
      end,
      fn
        [] -> {:cont, []}
        acc -> {:cont, acc, []}
      end
    )
    |> Enum.map(fn cs ->
      len = length(cs)
      if len > 1, do: "#{len}#{hd(cs)}", else: "#{hd(cs)}"
    end)
    |> Enum.join()
  end

  @spec decode(String.t()) :: String.t()
  def decode(string) do
    string
    |> String.to_charlist()
    |> do_decode(0, "")
  end

  defp do_decode([], _n, ans), do: ans

  defp do_decode([c | cs], n, ans) do
    cond do
      c in ?0..?9 ->
        do_decode(cs, n * 10 + c - ?0, ans)

      n < 2 ->
        do_decode(cs, 0, ans <> to_string([c]))

      true ->
        s = List.duplicate([c], n) |> to_string()
        do_decode(cs, 0, ans <> s)
    end
  end
end
