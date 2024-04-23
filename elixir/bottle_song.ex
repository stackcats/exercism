defmodule BottleSong do
  @moduledoc """
  Handles lyrics of the popular children song: Ten Green Bottles
  """

  @dict %{0 => "no", 1 => "one", 2 => "two", 3 => "three", 4 => "four", 5 => "five", 6 => "six", 7 => "seven", 8 => "eight", 9 => "nine", 10 => "ten"}

  defp plural(1), do: ""
  defp plural(_), do: "s"

  @spec recite(pos_integer, pos_integer) :: String.t()
  def recite(start_bottle, take_down) do
    recite(start_bottle, take_down, [])
  end
  defp recite(_, 0, acc) do
    acc
    |> Enum.reverse()
    |> Enum.join("\n\n")
  end
  defp recite(start_bottle, take_down, acc) do
    s = """
    #{String.capitalize(@dict[start_bottle])} green bottle#{plural(start_bottle)} hanging on the wall,
    #{String.capitalize(@dict[start_bottle])} green bottle#{plural(start_bottle)} hanging on the wall,
    And if one green bottle should accidentally fall,
    There'll be #{@dict[start_bottle - 1]} green bottle#{plural(start_bottle-1)} hanging on the wall.\
    """
    recite(start_bottle - 1, take_down - 1, [s | acc])
  end
end

