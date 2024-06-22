defmodule AffineCipher do
  @m 26

  @typedoc """
  A type for the encryption key
  """
  @type key() :: %{a: integer, b: integer}

  @doc """
  Encode an encrypted message using a key
  """
  @spec encode(key :: key(), message :: String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def encode(%{a: a, b: b}, message) do
    if Integer.gcd(a, @m) > 1 do
      {:error, "a and m must be coprime."}
    else
      message
      |> String.downcase()
      |> String.replace(~r/[^a-z0-9]/, "")
      |> String.to_charlist()
      |> Enum.map(fn
        c when c in ?0..?9 -> c
        c -> rem(a * (c - ?a) + b, @m) + ?a
      end)
      |> Enum.chunk_every(5)
      |> Enum.map(&List.to_string/1)
      |> Enum.join(" ")
      |> then(&{:ok, &1})
    end
  end

  @doc """
  Decode an encrypted message using a key
  """
  @spec decode(key :: key(), message :: String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def decode(%{a: a, b: b}, encrypted) do
    if Integer.gcd(a, @m) > 1 do
      {:error, "a and m must be coprime."}
    else
      mmi = Enum.find(1..25, fn mmi -> rem(a * mmi, @m) == 1 end)

      encrypted
      |> String.replace(" ", "")
      |> String.to_charlist()
      |> Enum.map(fn
        c when c in ?0..?9 -> c
        c -> rem(mmi * Integer.mod(c - ?a - b, @m), @m) + ?a
      end)
      |> List.to_string()
      |> then(&{:ok, &1})
    end
  end
end
