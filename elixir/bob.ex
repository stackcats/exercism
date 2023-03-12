defmodule Bob do
  @spec hey(String.t()) :: String.t()
  def hey(input) do
    input = String.trim(input)

    cond do
      input == "" ->
        "Fine. Be that way!"

      upcase?(input) && String.last(input) == "?" ->
        "Calm down, I know what I'm doing!"

      upcase?(input) ->
        "Whoa, chill out!"

      String.last(input) == "?" ->
        "Sure."

      true ->
        "Whatever."
    end
  end

  def upcase?(s) do
    Regex.match?(~r/[[:upper:]]/, s) && not Regex.match?(~r/[[:lower:]]/, s)
  end
end
