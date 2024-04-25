defmodule ResistorColorTrio do
  @colors %{
      black: 0,
      brown: 1,
      red: 2,
      orange: 3,
      yellow: 4,
      green: 5,
      blue: 6,
      violet: 7,
      grey: 8,
      white: 9
  }

  @doc """
  Calculate the resistance value in ohms from resistor colors
  """
  @spec label(colors :: [atom]) :: {number, :ohms | :kiloohms | :megaohms | :gigaohms}
  def label([a, b, c|_]) do
    val = (@colors[a] * 10 + @colors[b]) * (10 ** @colors[c])
    [:kiloohms, :megaohms, :gigaohms]
    |> Enum.reduce_while({val, :ohms}, fn x, {v, u} ->
      if v >= 1000 do
        {:cont, {div(v, 1000), x}}
      else
        {:halt, {v, u}}
      end
    end)
  end
end

