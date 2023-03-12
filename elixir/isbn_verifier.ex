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
    isbn = isbn |> String.replace("-", "")

    if Regex.match?(~r/^\d{9}(\d|X)$/, isbn) do
      isbn
      |> String.to_charlist()
      |> Enum.with_index()
      |> Enum.reduce(0, fn {c, i}, acc ->
        d = if c == ?X, do: 10, else: c - ?0
        rem(acc + d * (10 - i), 11)
      end)
      |> then(&(&1 == 0))
    else
      false
    end
  end
end
