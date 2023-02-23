defmodule ListOps do
  @spec count(list) :: non_neg_integer
  def count(l), do: count(l, 0)
  defp count([], ct), do: ct
  defp count([_ | xs], ct), do: count(xs, ct + 1)

  @spec reverse(list) :: list
  def reverse(l), do: reverse(l, [])
  defp reverse([], r), do: r
  defp reverse([x | xs], r), do: reverse(xs, [x | r])

  @spec map(list, (any -> any)) :: list
  def map([], _f), do: []
  def map([x | xs], f), do: [f.(x) | map(xs, f)]

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter([], _f), do: []

  def filter([x | xs], f) do
    if f.(x), do: [x | filter(xs, f)], else: filter(xs, f)
  end

  @type acc :: any
  @spec foldl(list, acc, (any, acc -> acc)) :: acc
  def foldl([], acc, _f), do: acc

  def foldl([x | xs], acc, f) do
    foldl(xs, f.(x, acc), f)
  end

  @spec foldr(list, acc, (any, acc -> acc)) :: acc
  def foldr([], acc, _f), do: acc

  def foldr([x | xs], acc, f) do
    f.(x, foldr(xs, acc, f))
  end

  @spec append(list, list) :: list
  def append(a, b) do
    foldr(a, b, &[&1 | &2])
  end

  @spec concat([[any]]) :: [any]
  def concat([]), do: []

  def concat(ll) do
    foldr(ll, [], &append/2)
  end
end
