defmodule Say do
  @doc """
  Translate a positive integer into English.
  """
  @spec in_english(integer) :: {atom, String.t()}
  def in_english(number) when number < 0 or number >= 1_000_000_000_000 do
    {:error, "number is out of range"}
  end

  def in_english(0), do: {:ok, "zero"}

  def in_english(number) do
    Stream.unfold(number, fn
      0 -> nil
      n -> {rem(n, 1000), div(n, 1000)}
    end)
    |> Stream.map(&to/1)
    |> Stream.map(&String.trim/1)
    |> Enum.zip(["", "thousand", "million", "billion"])
    |> Enum.map(fn
      {"", _} -> ""
      {s, ""} -> "#{s}"
      {s, t} -> "#{s} #{t}"
    end)
    |> Enum.reject(&(&1 == ""))
    |> Enum.reverse()
    |> Enum.join(" ")
    |> then(&{:ok, &1})
  end

  def to(0), do: ""
  def to(1), do: "one"
  def to(2), do: "two"
  def to(3), do: "three"
  def to(4), do: "four"
  def to(5), do: "five"
  def to(6), do: "six"
  def to(7), do: "seven"
  def to(8), do: "eight"
  def to(9), do: "nine"
  def to(10), do: "ten"
  def to(11), do: "eleven"
  def to(12), do: "twelve"
  def to(13), do: "thirteen"
  def to(14), do: "fourteen"
  def to(15), do: "fifteen"
  def to(16), do: "sixteen"
  def to(17), do: "seventeen"
  def to(18), do: "eighteen"
  def to(19), do: "nineteen"
  def to(20), do: "twenty"
  def to(30), do: "thirty"
  def to(40), do: "forty"
  def to(50), do: "fifty"
  def to(60), do: "sixty"
  def to(70), do: "seventy"
  def to(80), do: "eighty"
  def to(90), do: "ninety"

  def to(n) when n < 100 do
    "#{div(n, 10) |> Kernel.*(10) |> to()}-#{rem(n, 10) |> to()}"
  end

  def to(n) do
    "#{div(n, 100) |> to()} hundred #{rem(n, 100) |> to()}"
  end
end
