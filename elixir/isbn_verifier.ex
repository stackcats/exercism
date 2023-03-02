defmodule IsbnVerifier do
  @doc """
    Checks if a string is a valid ISBN-10 identifier

    ## Examples

      iex> IsbnVerifier.isbn?("3-598-21507-X")
      true

      iex> IsbnVerifier.isbn?("3-598-2K507-0")
      false

  """
  @spec isbn?(String.t()) :: boolean
  def isbn?(isbn) do
    isbn
    |> String.replace("-", "")
    |> String.to_charlist()
    |> Enum.with_index()
    |> Enum.reduce(0, fn {c, i}, acc ->
      d = if c == ?X, do: 10, else: c - ?a
      acc + d * (10 - i)
    end)
    |> then(&(rem(&1, 11) == 0))
  end
end
