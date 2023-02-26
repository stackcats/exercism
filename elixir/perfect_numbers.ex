defmodule PerfectNumbers do
  @doc """
  Determine the aliquot sum of the given `number`, by summing all the factors
  of `number`, aside from `number` itself.

  Based on this sum, classify the number as:

  :perfect if the aliquot sum is equal to `number`
  :abundant if the aliquot sum is greater than `number`
  :deficient if the aliquot sum is less than `number`
  """
  @spec classify(number :: integer) :: {:ok, atom} | {:error, String.t()}
  def classify(number) when number < 1 do
    {:error, "Classification is only possible for natural numbers."}
  end

  def classify(number) do
    for i <- 1..(number - 1)//1, rem(number, i) == 0 do
      i
    end
    |> Enum.sum()
    |> then(fn n ->
      cond do
        n == number -> {:ok, :perfect}
        n < number -> {:ok, :deficient}
        true -> {:ok, :abundant}
      end
    end)
  end
end
