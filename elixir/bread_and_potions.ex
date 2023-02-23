defmodule RPG do
  defmodule Character do
    defstruct health: 100, mana: 0
  end

  defmodule LoafOfBread do
    defstruct []
  end

  defmodule ManaPotion do
    defstruct strength: 10
  end

  defmodule Poison do
    defstruct []
  end

  defmodule EmptyBottle do
    defstruct []
  end

  # Add code to define the protocol and its implementations below here...
  defprotocol Edible do
    def eat(item, ch)
  end

  defimpl Edible, for: LoafOfBread do
    def eat(_bread, ch) do
      {nil, %{ch | health: ch.health + 5}}
    end
  end

  defimpl Edible, for: ManaPotion do
    def eat(potion, ch) do
      {%EmptyBottle{}, %{ch | mana: ch.mana + potion.strength}}
    end
  end

  defimpl Edible, for: Poison do
    def eat(_poison, ch) do
      {%RPG.EmptyBottle{}, %{ch | health: 0}}
    end
  end
end
