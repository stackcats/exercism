defmodule TwelveDays do
  @doc """
  Given a `number`, return the song's verse for that specific day, including
  all gifts for previous days in the same line.
  """
  @spec verse(number :: integer) :: String.t()
  def verse(number) do
    "On the #{n(number)} day of Christmas my true love gave to me: #{give(number)}."
  end

  defp n(1), do: "first"
  defp n(2), do: "second"
  defp n(3), do: "third"
  defp n(4), do: "fourth"
  defp n(5), do: "fifth"
  defp n(6), do: "sixth"
  defp n(7), do: "seventh"
  defp n(8), do: "eighth"
  defp n(9), do: "ninth"
  defp n(10), do: "tenth"
  defp n(11), do: "eleventh"
  defp n(12), do: "twelfth"

  defp give(1), do: v(1)

  defp give(n) do
    n..2
    |> Enum.map(&v/1)
    |> List.insert_at(-1, "and #{v(1)}")
    |> Enum.join(", ")
  end

  defp v(1), do: "a Partridge in a Pear Tree"
  defp v(2), do: "two Turtle Doves"
  defp v(3), do: "three French Hens"
  defp v(4), do: "four Calling Birds"
  defp v(5), do: "five Gold Rings"
  defp v(6), do: "six Geese-a-Laying"
  defp v(7), do: "seven Swans-a-Swimming"
  defp v(8), do: "eight Maids-a-Milking"
  defp v(9), do: "nine Ladies Dancing"
  defp v(10), do: "ten Lords-a-Leaping"
  defp v(11), do: "eleven Pipers Piping"
  defp v(12), do: "twelve Drummers Drumming"

  @doc """
  Given a `starting_verse` and an `ending_verse`, return the verses for each
  included day, one per line.
  """
  @spec verses(starting_verse :: integer, ending_verse :: integer) :: String.t()
  def verses(starting_verse, ending_verse) do
    starting_verse..ending_verse
    |> Enum.map(&verse/1)
    |> Enum.join("\n")
  end

  @doc """
  Sing all 12 verses, in order, one verse per line.
  """
  @spec sing() :: String.t()
  def sing do
    verses(1, 12)
  end
end
