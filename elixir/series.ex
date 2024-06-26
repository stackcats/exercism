defmodule Series do
  @doc """
  Finds the largest product of a given number of consecutive numbers in a given string of numbers.
  """
  @spec largest_product(String.t(), non_neg_integer) :: non_neg_integer
  def largest_product(number_string, size) do
    if size <= 0 or String.length(number_string) < size do
      raise ArgumentError
    else
      number_string
      |> String.graphemes()
      |> Enum.map(&String.to_integer/1)
      |> Enum.chunk_every(size, 1, :discard)
      |> Enum.max_by(&Enum.product/1)
      |> Enum.product()
    end
  end
end

