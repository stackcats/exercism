defmodule GoCounting do
  @type position :: {integer, integer}
  @type owner :: %{owner: atom, territory: [position]}
  @type territories :: %{white: [position], black: [position], none: [position]}

  @doc """
  Return the owner and territory around a position
  """
  @spec territory(board :: String.t(), position :: position) ::
          {:ok, owner} | {:error, String.t()}
  def territory(board, {x, y} = pos) do
    g = to_grid(board)
    {c, r} = g |> Map.keys() |> Enum.max()

    cond do
      x < 0 or y < 0 or y > c or x > r ->
        {:error, "Invalid coordinate"}

      g[{x, y}] != "_" ->
        {:ok, %{owner: :none, territory: []}}

      true ->
        g
        |> to_groups()
        |> Enum.find(&(pos in &1))
        |> then(fn t ->
          {:ok, %{owner: check(t, g), territory: t}}
        end)
    end
  end

  defp check(lst, g) do
    lst
    |> Enum.reduce({0, 0}, fn {x, y}, acc ->
      [{-1, 0}, {0, 1}, {1, 0}, {0, -1}]
      |> Enum.reduce(acc, fn {dx, dy}, {b, w} ->
        case g[{x + dx, y + dy}] do
          "B" -> {b + 1, w}
          "W" -> {b, w + 1}
          _ -> {b, w}
        end
      end)
    end)
    |> case do
      {0, 0} -> :none
      {_, 0} -> :black
      {0, _} -> :white
      _ -> :none
    end
  end

  defp to_groups(g) do
    g
    |> Enum.reduce({[], %MapSet{}}, fn
      {_, c}, acc when c != "_" ->
        acc

      {pos, _}, {groups, visited} ->
        {group, visited} =
          pos
          |> :queue.in(:queue.new())
          |> bfs(visited, g, [])

        {[group | groups], visited}
    end)
    |> elem(0)
  end

  defp to_grid(board) do
    board
    |> String.split("\n")
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn {r, i}, acc ->
      r
      |> String.graphemes()
      |> Enum.with_index()
      |> Enum.reduce(acc, fn {c, j}, acc ->
        Map.put(acc, {j, i}, c)
      end)
    end)
  end

  defp bfs(q, visited, g, group) do
    case :queue.out(q) do
      {:empty, _} ->
        {Enum.sort(group), visited}

      {{:value, pos = {x, y}}, q} ->
        cond do
          pos in visited ->
            bfs(q, visited, g, group)

          g[pos] != "_" ->
            bfs(q, visited, g, group)

          true ->
            visited = MapSet.put(visited, pos)
            group = [pos | group]

            [{-1, 0}, {0, 1}, {1, 0}, {0, -1}]
            |> Enum.reduce(q, fn {dx, dy}, q ->
              :queue.in({x + dx, y + dy}, q)
            end)
            |> bfs(visited, g, group)
        end
    end
  end

  @doc """
  Return all white, black and neutral territories
  """
  @spec territories(board :: String.t()) :: territories
  def territories(board) do
    g = board |> to_grid()

    g
    |> to_groups()
    |> Enum.reduce(%{black: [], none: [], white: []}, fn t, acc ->
      k = check(t, g)
      Map.update!(acc, k, &(&1 ++ t))
    end)
    |> Map.new(fn {k, v} -> {k, Enum.sort(v)} end)
  end
end
