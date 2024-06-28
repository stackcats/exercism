defmodule BookStore do
  @typedoc "A book is represented by its number in the 5-book series"
  @type book :: 1 | 2 | 3 | 4 | 5

  @discounts [0, 0, 0.05, 0.1, 0.2, 0.25]

  @doc """
  Calculate lowest price (in cents) for a shopping basket containing books.
  """
  @spec total(basket :: [book]) :: integer
  def total(basket) do
    basket
    |> Enum.frequencies()
    |> Stream.unfold(fn
      mp when map_size(mp) == 0 ->
        nil

      mp ->
        next =
          mp
          |> Map.new(fn {k, v} -> {k, v - 1} end)
          |> Map.reject(fn {_, v} -> v == 0 end)

        {map_size(mp), next}
    end)
    |> Enum.frequencies()
    |> then(fn mp ->
      case min(mp[3] || 0, mp[5] || 0) do
        0 ->
          mp

        n ->
          mp
          |> Map.update!(3, &(&1 - n))
          |> Map.update!(5, &(&1 - n))
          |> Map.update(4, n * 2, &(&1 + n * 2))
      end
    end)
    |> Enum.reduce(0, fn {k, v}, acc ->
      acc + k * v * floor(800 * (1 - Enum.at(@discounts, k)))
    end)
  end
end

