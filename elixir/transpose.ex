defmodule Transpose do
  @doc """
  Given an input text, output it transposed.

  Rows become columns and columns become rows. See https://en.wikipedia.org/wiki/Transpose.

  If the input has rows of different lengths, this is to be solved as follows:
    * Pad to the left with spaces.
    * Don't pad to the right.

  ## Examples

    iex> Transpose.transpose("ABC\\nDE")
    "AD\\nBE\\nC"

    iex> Transpose.transpose("AB\\nDEF")
    "AD\\nBE\\n F"
  """

  @spec transpose(String.t()) :: String.t()
  def transpose(""), do: ""

  def transpose(input) do
    lst = String.split(input, "\n")
    longest = Enum.max_by(lst, &String.length/1)
    len = String.length(longest)
    ndx = Enum.find_index(lst, &(&1 == longest))

    lst
    |> Enum.map(fn s ->
      s
      |> String.pad_trailing(len)
      |> String.graphemes()
    end)
    |> Enum.zip()
    |> Enum.map(fn x -> Tuple.to_list(x) |> Enum.join() end)
    |> Enum.reverse()
    |> Stream.transform(0, fn s, max_len ->
      t =
        s
        |> String.trim_trailing()
        |> String.pad_trailing(max_len)

      {[t], max(max_len, String.length(t))}
    end)
    |> Enum.reverse()
    |> Enum.join("\n")
  end
end
