defmodule FoodChain do
  @foods ~w(fly spider bird cat dog goat cow horse)

  @doc """
  Generate consecutive verses of the song 'I Know an Old Lady Who Swallowed a Fly'.
  """
  @spec recite(start :: integer, stop :: integer) :: String.t()
  def recite(start, stop) do
    start..stop
    |> Enum.map(&recite(&1 - 1))
    |> Enum.join("\n")
  end

  defp recite(v) do
    animal = Enum.at(@foods, v)
    s = "I know an old lady who swallowed a #{animal}.\n"

    s =
      s <>
        case animal do
          "spider" -> "It wriggled and jiggled and tickled inside her.\n"
          "bird" -> "How absurd to swallow a bird!\n"
          "cat" -> "Imagine that, to swallow a cat!\n"
          "dog" -> "What a hog, to swallow a dog!\n"
          "goat" -> "Just opened her throat and swallowed a goat!\n"
          "cow" -> "I don't know how she swallowed a cow!\n"
          "horse" -> "She's dead, of course!\n"
          _ -> ""
        end

    if animal == "horse" do
      s
    else
      v..1//-1
      |> Enum.reduce(s, fn v, acc ->
        acc <>
          case Enum.at(@foods, v - 1) do
            "spider" ->
              "She swallowed the #{Enum.at(@foods, v)} to catch the spider that wriggled and jiggled and tickled inside her.\n"

            u ->
              "She swallowed the #{Enum.at(@foods, v)} to catch the #{u}.\n"
          end
      end)
      |> Kernel.<>(
        "I don't know why she swallowed the #{Enum.at(@foods, 0)}. Perhaps she'll die.\n"
      )
    end
  end
end
