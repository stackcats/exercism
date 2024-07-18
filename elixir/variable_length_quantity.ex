defmodule VariableLengthQuantity do
  import Bitwise

  @doc """
  Encode integers into a bitstring of VLQ encoded bytes
  """
  @spec encode(integers :: [integer]) :: binary
  def encode(integers) do
    integers
    |> Enum.map(&do_encode/1)
    |> Enum.join(<<>>)
  end

  defp do_encode(n, more \\ 0) do
    case n &&& 0x7F do
      ^n -> <<more::1, n::7>>
      _ -> <<do_encode(n >>> 7, 1)::binary, more::1, n::7>>
    end
  end

  @doc """
  Decode a bitstring of VLQ encoded bytes into a series of integers
  """
  @spec decode(bytes :: binary) :: {:ok, [integer]} | {:error, String.t()}
  def decode(bytes) do
    bytes
    |> :binary.bin_to_list()
    |> Enum.reduce({[], 0, false}, fn b, {acc, n, complete?} ->
      n = n + (b &&& 0x7F)

      case b >>> 7 do
        0 -> {acc ++ [n], 0, true}
        _ -> {acc, n <<< 7, false}
      end
    end)
    |> case do
      {_, _, false} -> {:error, "incomplete sequence"}
      {acc, _, _} -> {:ok, acc}
    end
  end
end
