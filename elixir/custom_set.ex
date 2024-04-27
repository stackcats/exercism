defmodule CustomSet do
  defstruct map: %{}

  @opaque t :: %__MODULE__{map: map}

  @spec new(Enum.t()) :: t
  def new(enumerable) do
    %CustomSet{map: Map.new(enumerable, fn x -> {x, true} end)}
  end

  @spec empty?(t) :: boolean
  def empty?(custom_set) do
    Enum.empty?(custom_set.map)
  end

  @spec contains?(t, any) :: boolean
  def contains?(custom_set, element) do
    Map.has_key?(custom_set.map, element)
  end

  @spec subset?(t, t) :: boolean
  def subset?(custom_set_1, custom_set_2) do
    Map.intersect(custom_set_2.map, custom_set_1.map) == custom_set_1.map
  end

  @spec disjoint?(t, t) :: boolean
  def disjoint?(custom_set_1, custom_set_2) do
    Map.intersect(custom_set_2.map, custom_set_1.map)
    |> map_size()
    |> then(&(&1 == 0))
  end

  @spec equal?(t, t) :: boolean
  def equal?(custom_set_1, custom_set_2) do
    subset?(custom_set_1, custom_set_2) && subset?(custom_set_2, custom_set_1)
  end

  @spec add(t, any) :: t
  def add(custom_set, element) do
    %{custom_set | map: Map.update(custom_set.map, element, true, fn _ -> true end)}
  end

  @spec intersection(t, t) :: t
  def intersection(custom_set_1, custom_set_2) do
    %CustomSet{map: Map.intersect(custom_set_1.map, custom_set_2.map)}
  end

  @spec difference(t, t) :: t
  def difference(custom_set_1, custom_set_2) do
    %CustomSet{map: Map.drop(custom_set_1.map, Map.keys(custom_set_2.map))}
  end

  @spec union(t, t) :: t
  def union(custom_set_1, custom_set_2) do
    %CustomSet{map: Map.merge(custom_set_1.map, custom_set_2.map)}
  end
end

