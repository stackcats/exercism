defmodule CryptoSquare do
  @doc """
  Encode string square methods
  ## Examples

    iex> CryptoSquare.encode("abcd")
    "ac bd"
  """
  @spec encode(String.t()) :: String.t()
  def encode(str) do
    s = Regex.replace(~r/[^a-z0-9]/, String.downcase(str), "")
    {r, c} = s |> String.length() |> aux()

    mp = s
      |> String.to_charlist()
      |> Enum.reduce({%{}, 1, 1}, fn ch, {mp, i, j} ->
        mp = Map.put(mp, {i, j}, ch)
        i = i + 1
        {i, j} = if i > r, do: {1, j + 1}, else: {i, j}
        {mp, i, j}
      end)
      |> elem(0)

    for i <- 1..r//1 do
      for j <- 1..c//1 do
        Map.get(mp, {i, j}, ' ')
      end
    end
    |> Enum.join(" ")
  end

  defp aux(n) do
    r = round(n ** 0.5)
    if r * r < n, do: {r + 1, r}, else: {r, r}
  end
end
