defmodule Diamond do
  @doc """
  Given a letter, it prints a diamond starting with 'A',
  with the supplied letter at the widest point.
  """
  @spec build_shape(char) :: String.t()
  def build_shape(letter) do
    width = (letter - ?A) * 2 + 1
    top = ?A..letter
    bottom = (letter - 1)..?A//-1

    shape(top, width)
    |> Kernel.++(shape(bottom, width))
    |> Enum.join("")
  end

  defp shape(rng, width) do
    Enum.map(rng, &letter_shape(&1, width))
  end

  defp spaces(n) do
    Enum.map(1..n//1, fn _ -> " " end) |> Enum.join("")
  end

  defp letter_shape(?A, width) do
    n = div(width, 2)
    outer = spaces(n)
    "#{outer}A#{outer}\n"
  end

  defp letter_shape(c, width) do
    n = (c - ?A) * 2 + 1
    m = div(width - n, 2)
    outer = spaces(m)
    inner = spaces(n - 2)
    l = List.to_string([c])
    "#{outer}#{l}#{inner}#{l}#{outer}\n"
  end
end
