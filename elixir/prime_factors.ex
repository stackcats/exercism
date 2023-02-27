defmodule PrimeFactors do
  @doc """
  Compute the prime factors for 'number'.

  The prime factors are prime numbers that when multiplied give the desired
  number.

  The prime factors of 'number' will be ordered lowest to highest.
  """
  @spec factors_for(pos_integer) :: [pos_integer]
  def factors_for(number) do
    factors_for(number, 2, [])
  end

  def factors_for(number, fac, lst) when number < fac do
    Enum.reverse(lst)
  end

  def factors_for(number, fac, lst) do
    if rem(number, fac) == 0 do
      factors_for(div(number, fac), fac, [fac | lst])
    else
      factors_for(number, fac + 1, lst)
    end
  end
end
