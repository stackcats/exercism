defmodule Minesweeper do
  @doc """
  Annotate empty spots next to mines with the number of mines next to them.
  """
  @spec annotate([String.t()]) :: [String.t()]
  def annotate([]), do: []

  def annotate(board) do
    row = length(board)
    col = String.length(hd(board))

    mp =
      board
      |> Enum.with_index(1)
      |> Enum.reduce(%{}, fn {r, i}, acc ->
        r
        |> String.graphemes()
        |> Enum.with_index(1)
        |> Enum.reduce(acc, fn {c, j}, acc ->
          Map.put(acc, {i, j}, c)
        end)
      end)

    mp
    |> Map.new(fn
      {k, "*"} ->
        {k, "*"}

      {k = {x, y}, _} ->
        [{-1, -1}, {-1, 0}, {-1, 1}, {0, 1}, {1, 1}, {1, 0}, {1, -1}, {0, -1}]
        |> Enum.count(fn {dx, dy} ->
          mp[{x + dx, y + dy}] == "*"
        end)
        |> case do
          0 -> " "
          n -> to_string(n)
        end
        |> then(&{k, &1})
    end)
    |> then(fn mp ->
      for i <- 1..row do
        for j <- 1..col do
          mp[{i, j}]
        end
        |> Enum.join("")
      end
    end)
  end
end
