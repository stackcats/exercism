defmodule Hamming do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> Hamming.hamming_distance('AAGTCATA', 'TAGCGATC')
  {:ok, 4}
  """
  @spec hamming_distance([char], [char]) :: {:ok, non_neg_integer} | {:error, String.t()}
  def hamming_distance(strand1, strand2) do
    if length(strand1) != length(strand2) do
      {:error, "strands must be of equal length"}
    else
      Enum.zip(strand1, strand2)
      |> Enum.count(fn {c1, c2} -> c1 != c2 end)
      |> then(fn ct -> {:ok, ct} end)
    end
  end
end
