defmodule ZebraPuzzle do
  @nations [:englishman, :ukrainian, :spaniard, :norwegian, :japanese]
  @colors [:red, :green, :ivory, :yellow, :blue]
  @pets [:dog, :snails, :fox, :horse, :zebra]
  @drinks [:coffee, :tea, :milk, :juice, :water]
  @smokes [:old_gold, :kools, :chesterfields, :lucky_strike, :parliaments]

  @doc """
  Determine who drinks the water
  """
  @spec drinks_water() :: atom
  def drinks_water() do
    [nations, _, _, drinks, _] = solution()

    Enum.zip(nations, drinks)
    |> Enum.find(&match?({_, :water}, &1))
    |> elem(0)
  end

  @doc """
  Determine who owns the zebra
  """
  @spec owns_zebra() :: atom
  def owns_zebra() do
    [nations, _, pets, _, _] = solution()

    Enum.zip(nations, pets)
    |> Enum.find(&match?({_, :zebra}, &1))
    |> elem(0)
  end

  defp solution() do
    for nations <- permutations(@nations),
        match?([:norwegian | _], nations),
        colors <- permutations(@colors),
        right?(colors, :green, colors, :ivory),
        equal?(colors, :red, nations, :englishman),
        next_to?(nations, :norwegian, colors, :blue),
        pets <- permutations(@pets),
        equal?(nations, :spaniard, pets, :dog),
        drinks <- permutations(@drinks),
        match?([_, _, :milk, _, _], drinks),
        equal?(nations, :ukrainian, drinks, :tea),
        equal?(drinks, :coffee, colors, :green),
        smokes <- permutations(@smokes),
        next_to?(smokes, :chesterfields, pets, :fox),
        next_to?(smokes, :kools, pets, :horse),
        equal?(smokes, :lucky_strike, drinks, :juice),
        equal?(smokes, :kools, colors, :yellow),
        equal?(nations, :japanese, smokes, :parliaments),
        equal?(smokes, :old_gold, pets, :snails) do
      [nations, colors, pets, drinks, smokes]
    end
    |> hd()
  end

  defp equal?(xs, x, ys, y) do
    check(xs, x, ys, y, &==/2)
  end

  defp next_to?(xs, x, ys, y) do
    check(xs, x, ys, y, &(abs(&1 - &2) == 1))
  end

  defp right?(xs, x, ys, y) do
    check(xs, x, ys, y, &(&1 + 1 == &2))
  end

  defp check(xs, x, ys, y, f) do
    i = Enum.find_index(xs, &(&1 == x))
    j = Enum.find_index(ys, &(&1 == y))
    f.(i, j)
  end

  defp permutations(enumerable) do
    enumerable
    |> to_map()
    |> make_permutations()
  end

  defp to_map(enum), do: to_map(enum, fn _item, item_index -> item_index end)

  defp to_map(enum, key_function) when is_function(key_function, 1) do
    enum
    |> Stream.map(fn item -> {key_function.(item), item} end)
    |> Enum.into(%{})
  end

  defp to_map(enum, key_function) when is_function(key_function, 2) do
    enum
    |> Stream.with_index()
    |> Stream.map(fn {item, item_index} -> {key_function.(item, item_index), item} end)
    |> Enum.into(%{})
  end

  defp make_permutations(map) when map_size(map) == 0 do
    [[]]
  end

  defp make_permutations(map) when is_map(map) do
    map
    |> Stream.flat_map(fn {index, next} ->
      Map.delete(map, index)
      |> make_permutations()
      |> Stream.map(&[next | &1])
    end)
  end
end
