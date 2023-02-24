defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    if String.contains?(phrase, " ") do
      phrase
      |> String.split(" ")
      |> Enum.map(&translate/1)
      |> Enum.join(" ")
    else
      cond do
        Regex.match?(~r/^[xy][^aeiuo]/, phrase) ->
          phrase <> "ay"

        Regex.match?(~r/^[aeiou]/, phrase) ->
          phrase <> "ay"

        Regex.match?(~r/^[^aeiou]*qu/, phrase) ->
          [_, a, b] = Regex.run(~r/^([^aeiou]*qu)(.*)/, phrase)
          b <> a <> "ay"

        Regex.match?(~r/^[^aeiou]+[aeiou]/, phrase) ->
          [_, a, b] = Regex.run(~r/^([^aeiou]+)([aeiou].*)/, phrase)
          b <> a <> "ay"

        Regex.match?(~r/^(.*)y/, phrase) ->
          [_, a, b] = Regex.run(~r/^(.*)(y.*)/, phrase)
          b <> a <> "ay"
      end
    end
  end
end
