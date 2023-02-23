defmodule DNA do
  def encode_nucleotide(code_point) do
    case code_point do
      ?  -> 0b0000
      ?A -> 0b0001
      ?C -> 0b0010
      ?G -> 0b0100
      ?T -> 0b1000
    end
  end

  def decode_nucleotide(encoded_code) do
    case encoded_code do
      0b0000 -> ? 
      0b0001 -> ?A
      0b0010 -> ?C
      0b0100 -> ?G
      0b1000 -> ?T
    end
  end

  def encode(dna) do
    dna
    |> Enum.reduce(<<>>, fn x, acc ->
      <<acc::bitstring, encode_nucleotide(x)::size(4)>>
    end)
  end

  def decode(dna) do
    for <<x::size(4) <- dna>> do
      decode_nucleotide(x)
    end
  end
end
