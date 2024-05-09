defmodule Satellite do
  @typedoc """
  A tree, which can be empty, or made from a left branch, a node and a right branch
  """
  @type tree :: {} | {tree, any, tree}

  @doc """
  Build a tree from the elements given in a pre-order and in-order style
  """
  @spec build_tree(preorder :: [any], inorder :: [any]) :: {:ok, tree} | {:error, String.t()}
  def build_tree(preorder, inorder) do
    mp = MapSet.new(preorder)
    mi = MapSet.new(inorder)
    cond do
      MapSet.size(mp) != MapSet.size(mi) -> {:error, "traversals must have the same length"}
      not MapSet.equal?(mp, mi) -> {:error, "traversals must have the same elements"}
      MapSet.size(mp) != Enum.count(preorder) or MapSet.size(mi) != Enum.count(inorder) -> {:error, "traversals must contain unique items"}
      true -> {:ok, build(preorder, inorder)}
    end
  end

  defp build([], _), do: {}
  defp build([x|xs], ys) do
    {ly, ry} = Enum.split_while(ys, &(&1 != x))
    {lx, rx} = Enum.split(xs, Enum.count(ly))
    {build(lx, ly), x, build(rx, tl(ry))}
  end
end

