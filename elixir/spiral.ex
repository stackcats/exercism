defmodule Spiral do
  @doc """
  Given the dimension, return a square matrix of numbers in clockwise spiral order.
  """
  @spec matrix(dimension :: integer) :: list(list(integer))
  def matrix(dimension) do
    mp = 1..(dimension*dimension)
    |> Enum.reduce({%{}, 1, 1, 0, 1}, fn k, {mp, i, j, di, dj} ->
      mp = Map.put(mp, {i, j}, k)
      {ni, nj} = {i + di, j + dj}
      if ni < 1 or ni > dimension or nj < 1 or nj > dimension or mp[{ni, nj}] != nil do
        {di, dj} = {dj, -di}
        {mp, i + di, j + dj, di, dj}
      else
        {mp, i + di, j + dj, di, dj}
      end
    end)
    |> elem(0)

    for i <- 1..dimension//1 do
      for j <- 1..dimension//1 do
        mp[{i, j}]
      end
    end
  end
end

