defmodule Proverb do
  @doc """
  Generate a proverb from a list of strings.
  """
  @spec recite(strings :: [String.t()]) :: String.t()
  def recite([]), do: ""

  def recite(strings) do
    proverbs =
      strings
      |> Enum.chunk_every(2, 1, :discard)
      |> Enum.map(fn [a, b] -> "For want of a #{a} the #{b} was lost." end)

    (proverbs ++ ["And all for the want of a #{hd(strings)}.\n"])
    |> Enum.join("\n")
  end
end
