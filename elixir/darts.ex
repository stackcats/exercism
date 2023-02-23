defmodule Darts do
  @type position :: {number, number}
  @doc """
  Calculate the score of a single dart hitting a target
  """
  @spec score(position) :: integer
  def score({x, y}) do
    dis = :math.sqrt(x * x + y * y)

    cond do
      dis > 10 -> 0
      dis > 5 -> 1
      dis > 1 -> 5
      true -> 10
    end
  end
end
