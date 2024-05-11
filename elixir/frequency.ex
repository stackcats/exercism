defmodule Frequency do
  @doc """
  Count letter frequency in parallel.

  Returns a map of characters to frequencies.

  The number of worker processes to use can be set with 'workers'.
  """
  @spec frequency([String.t()], pos_integer) :: map
  def frequency([], _), do: %{}
  def frequency(texts, workers) do
    texts
    |> Task.async_stream(&count/1, [max_concurrency: workers])
    |> Enum.reduce(%{}, fn {:ok, res}, acc -> 
      Map.merge(res, acc, fn _k, v1, v2 -> v1 + v2 end)
    end)
  end

  defp count(text) do
    text
    |> String.downcase()
    |> String.replace(~r/[^\p{L}]/u, "")
    |> String.graphemes()
    |> Enum.frequencies()
  end
end

