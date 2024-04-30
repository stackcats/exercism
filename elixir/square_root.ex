defmodule SquareRoot do
  @doc """
  Calculate the integer square root of a positive integer
  """
  @spec calculate(radicand :: pos_integer) :: pos_integer
  def calculate(radicand) do
    Stream.drop_while(1..radicand, fn n -> n * n != radicand end)
    |> Enum.take(1)
    |> hd()
  end
end

