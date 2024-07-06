defmodule Markdown do
  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

      iex> Markdown.parse("This is a paragraph")
      "<p>This is a paragraph</p>"

      iex> Markdown.parse("# Header!\\n* __Bold Item__\\n* _Italic Item_")
      "<h1>Header!</h1><ul><li><strong>Bold Item</strong></li><li><em>Italic Item</em></li></ul>"
  """

  @spec parse(String.t()) :: String.t()
  def parse(m) do
    6..1
    |> Enum.reduce(m, fn i, s ->
      Regex.replace(~r/^#{String.duplicate("#", i)} (.*$)/m, s, "<h#{i}>\\1</h#{i}>")
    end)
    |> String.replace(~r/__(.*?)__/, "<strong>\\1</strong>")
    |> String.replace(~r/_(.*?)_/, "<em>\\1</em>")
    |> String.replace(~r/^\* (.*$)/m, "<li>\\1</li>")
    |> String.replace(~r/(<li>.*<\/li>)/s, "<ul>\\1</ul>")
    |> String.replace(~r/^(?!<[hlu])(.*$)/m, "<p>\\1</p>")
    |> String.replace("\n", "")
  end
end
