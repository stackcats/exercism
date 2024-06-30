defmodule WordSearch do
  defmodule Location do
    defstruct [:from, :to]

    @type t :: %Location{
            from: %{row: integer, column: integer},
            to: %{row: integer, column: integer}
          }

    def new({x1, y1}, {x2, y2}) do
      %Location{from: %{row: x1, column: y1}, to: %{row: x2, column: y2}}
    end
  end

  @doc """
  Find the start and end positions of words in a grid of letters.
  Row and column positions are 1 indexed.
  """
  @spec search(grid :: String.t(), words :: [String.t()]) :: %{String.t() => nil | Location.t()}
  def search(grid, words) do
    mp =
      grid
      |> String.split("\n")
      |> Enum.with_index(1)
      |> Enum.reduce(%{}, fn {r, i}, acc ->
        r
        |> String.graphemes()
        |> Enum.with_index(1)
        |> Enum.reduce(acc, fn {c, j}, acc ->
          Map.put(acc, {i, j}, c)
        end)
      end)

    words
    |> Map.new(fn word ->
      ws = String.graphemes(word)

      mp
      |> Enum.find_value(fn {p, _c} ->
        [{-1, -1}, {-1, 0}, {-1, 1}, {0, 1}, {1, 1}, {1, 0}, {1, -1}, {0, -1}]
        |> Enum.find_value(fn d -> check(mp, p, d, ws) end)
        |> case do
          nil -> nil
          q -> Location.new(p, q)
        end
      end)
      |> then(&{word, &1})
    end)
  end

  defp check(_, {x, y}, {dx, dy}, []), do: {x - dx, y - dy}

  defp check(mp, curr = {x, y}, d = {dx, dy}, [w | ws]) do
    if mp[curr] != w do
      nil
    else
      check(mp, {x + dx, y + dy}, d, ws)
    end
  end
end

