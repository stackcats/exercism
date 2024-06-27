defmodule SaddlePoints do
  @doc """
  Parses a string representation of a matrix
  to a list of rows
  """
  @spec rows(String.t()) :: [[integer]]
  def rows(""), do: []

  def rows(str) do
    str
    |> String.split("\n")
    |> Enum.map(fn r ->
      r
      |> String.split(" ")
      |> Enum.map(&String.to_integer/1)
    end)
  end

  @doc """
  Parses a string representation of a matrix
  to a list of columns
  """
  @spec columns(String.t()) :: [[integer]]
  def columns(str) do
    str
    |> rows()
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
  end

  @doc """
  Calculates all the saddle points from a string
  representation of a matrix
  """
  @spec saddle_points(String.t()) :: [{integer, integer}]
  def saddle_points(str) do
    rs = rows(str)
    cs = columns(str)
    ma = Enum.map(rs, &Enum.max/1)
    mi = Enum.map(cs, &Enum.min/1)

    for {row, i} <- Enum.with_index(rs),
        {n, j} <- Enum.with_index(row),
        Enum.at(ma, i) == n,
        Enum.at(mi, j) == n do
      {i + 1, j + 1}
    end
  end
end
