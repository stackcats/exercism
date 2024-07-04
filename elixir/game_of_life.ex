defmodule GameOfLife do
  @doc """
  Apply the rules of Conway's Game of Life to a grid of cells
  """

  @spec tick(matrix :: list(list(0 | 1))) :: list(list(0 | 1))
  def tick([]), do: []

  def tick(matrix) do
    matrix
    |> Enum.with_index(1)
    |> Enum.reduce(%{}, fn {r, i}, acc ->
      r
      |> Enum.with_index(1)
      |> Enum.reduce(acc, fn {c, j}, acc ->
        Map.put(acc, {i, j}, c)
      end)
    end)
    |> then(fn mp ->
      mp
      |> Map.new(fn {{i, j} = k, v} ->
        lives =
          [{-1, -1}, {-1, 0}, {-1, 1}, {0, 1}, {1, 1}, {1, 0}, {1, -1}, {0, -1}]
          |> Enum.count(fn {di, dj} -> mp[{i + di, j + dj}] == 1 end)

        cond do
          v == 1 and lives in 2..3 -> {k, v}
          v == 0 and lives == 3 -> {k, 1}
          true -> {k, 0}
        end
      end)
    end)
    |> then(fn mp ->
      for i <- 1..length(matrix) do
        for j <- 1..length(hd(matrix)) do
          mp[{i, j}]
        end
      end
    end)
  end
end
