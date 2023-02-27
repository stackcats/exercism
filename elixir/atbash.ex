defmodule Atbash do
  @doc """
  Encode a given plaintext to the corresponding ciphertext

  ## Examples

  iex> Atbash.encode("completely insecure")
  "xlnko vgvob rmhvx fiv"
  """
  @spec encode(String.t()) :: String.t()
  def encode(plaintext) do
    plaintext
    |> String.downcase()
    |> String.replace(~r/[^a-z0-9]/, "")
    |> String.to_charlist()
    |> Enum.map(fn c ->
      if c in ?0..?9, do: c, else: ?a + ?z - c
    end)
    |> Enum.chunk_every(5)
    |> Enum.map(&List.to_string/1)
    |> Enum.join(" ")
  end

  @spec decode(String.t()) :: String.t()
  def decode(cipher) do
    cipher
    |> String.replace(" ", "")
    |> String.to_charlist()
    |> Enum.map(fn c ->
      if c in ?0..?9, do: c, else: ?a + ?z - c
    end)
    |> List.to_string()
  end
end
