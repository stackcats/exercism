defmodule Pov do
  @typedoc """
  A tree, which is made of a node with several branches
  """
  @type tree :: {any, [tree]}

  @doc """
  Reparent a tree on a selected node.
  """
  @spec from_pov(tree :: tree, node :: any) :: {:ok, tree} | {:error, atom}
  def from_pov(tree, node) do
    nodes = get_nodes(tree, nil)

    if Map.has_key?(nodes, node) do
      {:ok, build_tree(node, nil, nodes)}
    else
      {:error, :nonexistent_target}
    end
  end

  defp build_tree(node, parent, nodes) do
    nodes[node]
    |> Enum.reject(&(&1 == parent))
    |> Enum.map(&build_tree(&1, node, nodes))
    |> then(&{node, &1})
  end

  defp get_nodes({t, children}, parent, mp \\ %{}) do
    ns =
      [parent | Enum.map(children, &elem(&1, 0))]
      |> Enum.reject(&is_nil/1)

    mp = Map.put(mp, t, ns)

    children
    |> Enum.reduce(mp, fn c, mp ->
      get_nodes(c, t, mp)
    end)
  end

  @doc """
  Finds a path between two nodes
  """
  @spec path_between(tree :: tree, from :: any, to :: any) :: {:ok, [any]} | {:error, atom}
  def path_between(tree, from, to) do
    nodes = get_nodes(tree, nil)

    cond do
      not Map.has_key?(nodes, from) ->
        {:error, :nonexistent_source}

      not Map.has_key?(nodes, to) ->
        {:error, :nonexistent_destination}

      true ->
        [from]
        |> :queue.in(:queue.new())
        |> bfs(%MapSet{}, to, nodes)
        |> then(&{:ok, &1})
    end
  end

  defp bfs(q, seen, target, nodes) do
    {{_, [node | _] = path}, q} = :queue.out(q)

    cond do
      node == target ->
        Enum.reverse(path)

      node in seen ->
        bfs(q, seen, target, nodes)

      true ->
        seen = MapSet.put(seen, node)

        nodes[node]
        |> Enum.reduce(q, fn n, q ->
          :queue.in([n | path], q)
        end)
        |> bfs(seen, target, nodes)
    end
  end
end
