defmodule Allergies do
  import Bitwise

  @doc """
  List the allergies for which the corresponding flag bit is true.
  """
  @spec list(non_neg_integer) :: [String.t()]
  def list(flags) do
    ["eggs", "peanuts", "shellfish", "strawberries", "tomatoes", "chocolate", "pollen", "cats"]
    |> Enum.reduce({[], 1}, fn item, {lst, mask} ->
      lst = if (flags &&& mask) > 0, do: [item | lst], else: lst
      {lst, mask <<< 1}
    end)
    |> elem(0)
  end

  @doc """
  Returns whether the corresponding flag bit in 'flags' is set for the item.
  """
  @spec allergic_to?(non_neg_integer, String.t()) :: boolean
  def allergic_to?(flags, item) do
    flags
    |> list()
    |> Enum.find(&(&1 == item))
  end
end
