defmodule WordCount do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    ~r/([a-z0-9]+'[a-z0-9]+|[a-z0-9]+)/
    |> Regex.scan(String.downcase(sentence))
    |> Enum.reduce(%{}, fn [_, w], acc ->
      Map.update(acc, w, 1, &(&1 + 1))
    end)
  end
end

