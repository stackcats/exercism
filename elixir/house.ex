defmodule House do
  @clauses [
    "the house that Jack built.",
    "the malt that lay in",
    "the rat that ate",
    "the cat that killed",
    "the dog that worried",
    "the cow with the crumpled horn that tossed",
    "the maiden all forlorn that milked",
    "the man all tattered and torn that kissed",
    "the priest all shaven and shorn that married",
    "the rooster that crowed in the morn that woke",
    "the farmer sowing his corn that kept",
    "the horse and the hound and the horn that belonged to",
  ]
  
  @doc """
  Return verses of the nursery rhyme 'This is the House that Jack Built'.
  """
  @spec recite(start :: integer, stop :: integer) :: String.t()
  def recite(start, stop) do
    for v <- start..stop do
      verse(v)
    end
    |> Enum.join("")
  end

  defp verse(v) do
    @clauses
    |> Enum.take(v)
    |> Enum.reverse()
    |> Enum.join(" ")
    |> then(&("This is #{&1}\n"))
  end
end

