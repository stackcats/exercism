defmodule OcrNumbers do
  @doc """
  Given a 3 x 4 grid of pipes, underscores, and spaces, determine which number is represented, or
  whether it is garbled.
  """
  @spec convert([String.t()]) :: {:ok, String.t()} | {:error, String.t()}
  def convert(input) do
    cond do
      rem(length(input), 4) != 0 ->
        {:error, "invalid line count"}

      Enum.any?(input, &(rem(String.length(&1), 3) != 0)) ->
        {:error, "invalid column count"}

      true ->
        input
        |> Enum.chunk_every(4)
        |> Enum.map(&do_convert/1)
        |> Enum.join(",")
        |> then(&{:ok, &1})
    end
  end

  @mapping %{
    " _ | ||_|   " => "0",
    "     |  |   " => "1",
    " _  _||_    " => "2",
    " _  _| _|   " => "3",
    "   |_|  |   " => "4",
    " _ |_  _|   " => "5",
    " _ |_ |_|   " => "6",
    " _   |  |   " => "7",
    " _ |_||_|   " => "8",
    " _ |_| _|   " => "9"
  }

  defp do_convert(input) do
    input
    |> Stream.map(&String.graphemes/1)
    |> Stream.map(&Enum.chunk_every(&1, 3))
    |> Enum.zip()
    |> Enum.map(fn x ->
      x
      |> Tuple.to_list()
      |> List.flatten()
      |> Enum.join("")
      |> then(&Map.get(@mapping, &1, "?"))
    end)
    |> Enum.join("")
  end
end
