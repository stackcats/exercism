defmodule ArmstrongNumber do
  @moduledoc """
  Provides a way to validate whether or not a number is an Armstrong number
  """

  @spec valid?(integer) :: boolean
  def valid?(number) do
    ndigits = number |> to_string() |> String.length()
    aux(number, 0, ndigits) == number
  end

  def aux(0, acc, _p), do: acc

  def aux(n, acc, p) do
    aux(div(n, 10), acc + rem(n, 10) ** p, p)
  end
end
