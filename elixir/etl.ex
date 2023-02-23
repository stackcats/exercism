defmodule ETL do
  @doc """
  Transforms an old Scrabble score system to a new one.

  ## Examples

    iex> ETL.transform(%{1 => ["A", "E"], 2 => ["D", "G"]})
    %{"a" => 1, "d" => 2, "e" => 1, "g" => 2}
  """
  @spec transform(map) :: map
  def transform(input) do
    input
    |> Enum.reduce(%{}, fn {n, lst}, acc ->
      lst
      |> Enum.reduce(acc, fn c, acc ->
        Map.put(acc, String.downcase(c), n)
      end)
    end)
  end
end
