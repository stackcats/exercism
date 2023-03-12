defmodule PascalsTriangle do
  @doc """
  Calculates the rows of a pascal triangle
  with the given height
  """
  @spec rows(integer) :: [[integer]]
  def rows(num) do
    num
    |> do_rows()
    |> Enum.reverse()
  end

  defp do_rows(1), do: [[1]]

  defp do_rows(num) do
    rs = do_rows(num - 1)
    prev = hd(rs)

    curr =
      prev
      |> Enum.chunk_every(2, 1)
      |> Enum.flat_map(fn lst -> [Enum.sum(lst)] end)

    [[1 | curr] | rs]
  end
end
