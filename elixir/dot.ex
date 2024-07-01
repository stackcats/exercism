defmodule Dot do
  defmacro graph(do: block) do
    block
    |> aux(Graph.new())
    |> Macro.escape()
  end

  defp aux({:__block__, _, []}, acc), do: acc

  defp aux({:__block__, _, blocks}, acc) do
    blocks |> Enum.reduce(acc, &aux/2)
  end

  defp aux({:graph, _, attrs}, acc) do
    Graph.put_attrs(acc, to_attrs(attrs))
  end

  defp aux({:--, _, [{a, _, _}, {b, _, attrs}]}, acc) do
    acc
    |> Graph.add_node(a)
    |> Graph.add_node(b)
    |> Graph.add_edge(a, b, to_attrs(attrs))
  end

  defp aux({node, _, attrs}, acc) when is_atom(node) do
    Graph.add_node(acc, node, to_attrs(attrs))
  end

  defp aux(_, _), do: raise(ArgumentError)

  defp to_attrs(nil), do: []
  defp to_attrs([attrs]) when is_list(attrs), do: attrs
  defp to_attrs(_), do: raise(ArgumentError)
end
