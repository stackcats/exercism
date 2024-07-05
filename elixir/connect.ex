defmodule Connect do
  @doc """
  Calculates the winner (if any) of a board
  using "O" as the white player
  and "X" as the black player
  """
  @spec result_for([String.t()]) :: :none | :black | :white
  def result_for(board) do
    mp =
      board
      |> tap(fn x -> Enum.join(x, "\n") |> IO.puts() end)
      |> Enum.with_index(1)
      |> Enum.reduce(%{}, fn {r, i}, acc ->
        r
        |> String.graphemes()
        |> Enum.with_index(1)
        |> Enum.reduce(acc, fn {c, j}, acc ->
          Map.put(acc, {i, j}, c)
        end)
      end)

    {r, c} = mp |> Map.keys() |> Enum.max()

    cond do
      check(mp, "O", Enum.map(1..c, &{1, &1}), fn {i, _} -> i >= r end) -> :white
      check(mp, "X", Enum.map(1..r, &{&1, 1}), fn {_, j} -> j >= c end) -> :black
      true -> :none
    end
  end

  defp check(mp, target, starts, win?) do
    starts
    |> Enum.filter(fn p -> mp[p] == target end)
    |> Enum.find(false, fn pos ->
      pos
      |> :queue.in(:queue.new())
      |> bfs(mp, %MapSet{}, target, win?)
    end)
  end

  defp bfs(q, mp, seen, target, win?) do
    case :queue.out(q) do
      {:empty, _} ->
        false

      {{:value, {i, j} = pos}, q} ->
        cond do
          pos in seen ->
            bfs(q, mp, seen, target, win?)

          win?.(pos) ->
            true

          true ->
            seen = MapSet.put(seen, pos)

            [{0, 1}, {-1, 0}, {0, -1}, {1, 0}, {1, -1}, {-1, 1}]
            |> Enum.reduce(q, fn {di, dj}, q ->
              p = {di + i, dj + j}

              case mp[p] do
                ^target -> :queue.in(p, q)
                _ -> q
              end
            end)
            |> bfs(mp, seen, target, win?)
        end
    end
  end
end
