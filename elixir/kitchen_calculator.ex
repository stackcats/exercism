defmodule KitchenCalculator do
  def get_volume({_, v}) do
    v
  end

  def to_milliliter({:cup, v}), do: {:milliliter, 240 * v}
  def to_milliliter({:fluid_ounce, v}), do: {:milliliter, 30 * v}
  def to_milliliter({:teaspoon, v}), do: {:milliliter, 5 * v}
  def to_milliliter({:tablespoon, v}), do: {:milliliter, 15 * v}
  def to_milliliter(volume_pair), do: volume_pair

  def from_milliliter({_, v}, :cup), do: {:cup, v / 240}
  def from_milliliter({_, v}, :fluid_ounce), do: {:fluid_ounce, v / 30}
  def from_milliliter({_, v}, :teaspoon), do: {:teaspoon, v / 5}
  def from_milliliter({_, v}, :tablespoon), do: {:tablespoon, v / 15}
  def from_milliliter(volume_pair, _), do: volume_pair

  def convert(volume_pair, unit) do
    volume_pair |> to_milliliter() |> from_milliliter(unit)
  end
end
