defmodule Yacht do
  @type category ::
          :ones
          | :twos
          | :threes
          | :fours
          | :fives
          | :sixes
          | :full_house
          | :four_of_a_kind
          | :little_straight
          | :big_straight
          | :choice
          | :yacht

  @doc """
  Calculate the score of 5 dice using the given category's scoring method.
  """
  @spec score(category :: category(), dice :: [integer]) :: integer
  def score(category, dice) do
    {mp, sum} =
      dice
      |> Enum.reduce({%{}, 0}, fn d, {mp, sum} ->
        {Map.update(mp, d, 1, &(&1 + 1)), sum + d}
      end)

    case category do
      :ones ->
        Map.get(mp, 1, 0)

      :twos ->
        Map.get(mp, 2, 0) * 2

      :threes ->
        Map.get(mp, 3, 0) * 3

      :fours ->
        Map.get(mp, 4, 0) * 4

      :fives ->
        Map.get(mp, 5, 0) * 5

      :sixes ->
        Map.get(mp, 6, 0) * 6

      :full_house ->
        if contain?(mp, [3, 2]), do: sum, else: 0

      :four_of_a_kind ->
        Enum.reduce_while(mp, 0, fn {k, v}, acc ->
          if v >= 4, do: {:halt, 4 * k}, else: {:cont, acc}
        end)

      :little_straight ->
        if Enum.sort(dice) == [1, 2, 3, 4, 5], do: 30, else: 0

      :big_straight ->
        if Enum.sort(dice) == [2, 3, 4, 5, 6], do: 30, else: 0

      :yacht ->
        if contain?(mp, [5]), do: 50, else: 0

      :choice ->
        sum

      _ ->
        0
    end
  end

  defp contain?(mp, targets) do
    st = mp |> Map.values() |> MapSet.new()
    targets |> MapSet.new() |> MapSet.subset?(st)
  end
end
