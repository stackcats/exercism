defmodule Rectangles do
  @doc """
  Count the number of ASCII rectangles.
  """
  @spec count(input :: String.t()) :: integer
  def count(input) do
    mp = input
    |> String.split("\n")
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn {line, i}, acc ->
      line
      |> String.graphemes()
      |> Enum.with_index()
      |> Enum.reduce(acc, fn {c, j}, acc ->
        Map.put(acc, {i, j}, c)
      end)
    end)

    corners = mp
    |> Enum.flat_map(fn {k, v} -> if v == "+", do: [k], else: [] end) 
    |> Enum.sort()

    n = length(corners)

    for a <- 0..(n-4)//1, b <- (a+1)..(n-3)//1, c <- (b+1)..(n-2)//1, d <- (c+1)..(n-1)//1, reduce: 0 do
      acc ->
        acc + if rect?(Enum.at(corners, a), Enum.at(corners, b), Enum.at(corners, c), Enum.at(corners, d), mp), do: 1, else: 0
    end
  end

  defp rect?({x1, y1}, {x1, y2}, {x2, y1}, {x2, y2}, mp) do
    h = ["+", "-"]
    v = ["+", "|"] 
    not Enum.any?(x1..x2, fn x -> mp[{x, y1}] not in v or mp[{x, y2}] not in v end) and not Enum.any?(y1..y2, fn y -> mp[{x1, y}] not in h or mp[{x2, y}] not in h end)
  end
  defp rect?(_, _, _, _, _), do: false
end

