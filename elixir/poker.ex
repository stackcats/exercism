defmodule Poker do
  @doc """
  Given a list of poker hands, return a list containing the highest scoring hand.

  If two or more hands tie, return the list of tied hands in the order they were received.

  The basic rules and hand rankings for Poker can be found at:

  https://en.wikipedia.org/wiki/List_of_poker_hands

  For this exercise, we'll consider the game to be using no Jokers,
  so five-of-a-kind hands will not be tested. We will also consider
  the game to be using multiple decks, so it is possible for multiple
  players to have identical cards.

  Aces can be used in low (A 2 3 4 5) or high (10 J Q K A) straights, but do not count as
  a high card in the former case.

  For example, (A 2 3 4 5) will lose to (2 3 4 5 6).

  You can also assume all inputs will be valid, and do not need to perform error checking
  when parsing card values. All hands will be a list of 5 strings, containing a number
  (or letter) for the rank, followed by the suit.

  Ranks (lowest to highest): 2 3 4 5 6 7 8 9 10 J Q K A
  Suits (order doesn't matter): C D H S

  Example hand: ~w(4S 5H 4C 5D 4H) # Full house, 5s over 4s
  """
  @spec best_hand(list(list(String.t()))) :: list(list(String.t()))
  def best_hand(hands) do
    [h | hs] =
      hands
      |> Enum.map(&rank/1)
      |> Enum.sort(fn a, b ->
        if a.rank == b.rank, do: a.cards >= b.cards, else: a.rank <= b.rank
      end)

    hs
    |> Enum.take_while(fn each -> each.rank == h.rank and each.cards == h.cards end)
    |> Kernel.++([h])
    |> Enum.map(fn h -> h.hand end)
  end

  @r_steel_wheel [14, 5, 4, 3, 2]
  @steel_wheel [5, 4, 3, 2, 14]

  defp rank(hand) do
    {cards, suits} =
      hand
      |> Enum.reduce({[], %MapSet{}}, fn
        "10" <> <<suit>>, {cards, suits} ->
          {[10 | cards], MapSet.put(suits, suit)}

        s, {cards, suits} ->
          [card, suit] = String.to_charlist(s)
          {[card_rank(card) | cards], MapSet.put(suits, suit)}
      end)

    cf = Enum.frequencies(cards)

    cards =
      cards
      |> Enum.sort_by(&{-cf[&1], -&1})
      |> case do
        @r_steel_wheel -> @steel_wheel
        cards -> cards
      end

    is_straight = straight?(cards)
    is_flush = MapSet.size(suits) == 1

    cond do
      is_straight and is_flush -> 1
      has?(cf, 4) -> 2
      has?(cf, 3) and has?(cf, 2) -> 3
      is_flush -> 4
      is_straight -> 5
      has?(cf, 3) -> 6
      count(cf, 2) == 2 -> 7
      has?(cf, 2) -> 8
      true -> 100
    end
    |> then(fn r ->
      %{rank: r, cards: cards, hand: hand}
    end)
  end

  defp card_rank(?A), do: 14
  defp card_rank(?K), do: 13
  defp card_rank(?Q), do: 12
  defp card_rank(?J), do: 11
  defp card_rank(c), do: c - ?0

  defp has?(mp, v) do
    v in Map.values(mp)
  end

  defp count(mp, v) do
    mp
    |> Map.values()
    |> Enum.frequencies()
    |> Map.get(v, 0)
  end

  defp straight?(cards) do
    cards == @steel_wheel or
      Enum.chunk_every(cards, 2, 1, :discard)
      |> Enum.all?(fn [a, b] -> a - b == 1 end)
  end
end
