defmodule RailFenceCipher do
  @doc """
  Encode a given plaintext to the corresponding rail fence ciphertext
  """
  @spec encode(String.t(), pos_integer) :: String.t()
  def encode(str, rails) do
    t = String.graphemes(str)

    str
    |> String.length()
    |> mapping(rails)
    |> Enum.with_index()
    |> Enum.reduce(t, fn {v, i}, t ->
      List.replace_at(t, i, String.at(str, v))
    end)
    |> Enum.join()
  end

  @doc """
  Decode a given rail fence ciphertext to the corresponding plaintext
  """
  @spec decode(String.t(), pos_integer) :: String.t()
  def decode(str, rails) do
    t = String.graphemes(str)

    str
    |> String.length()
    |> mapping(rails)
    |> Enum.with_index()
    |> Enum.reduce(t, fn {v, i}, t ->
      List.replace_at(t, v, String.at(str, i))
    end)
    |> Enum.join()
  end

  defp mapping(n, rails) do
    0..(n - 1)
    |> Enum.reduce({%{}, 0, 1}, fn i, {acc, j, dj} ->
      acc = Map.update(acc, j, [i], &(&1 ++ [i]))
      j = j + dj
      dj = if j == 0 or j == rails - 1, do: -dj, else: dj
      {acc, j, dj}
    end)
    |> elem(0)
    |> Enum.sort_by(&elem(&1, 0))
    |> Enum.map(&elem(&1, 1))
    |> List.flatten()
  end
end
