defmodule Dominoes do
  @type domino :: {1..6, 1..6}

  @doc """
  chain?/1 takes a list of domino stones and returns boolean indicating if it's
  possible to make a full chain
  """
  @spec chain?(dominoes :: [domino]) :: boolean
  def chain?(dominoes) do
    dfs(dominoes, [])
  end

  defp dfs([], []), do: true
  defp dfs([], ys) do
    {a, _} = hd(ys)
    {_, d} = List.last(ys)
    a == d
  end
  defp dfs(xs, []) do
    xs
    |> Enum.reduce_while(false, fn {a, b} = x, acc ->
      zs = List.delete(xs, x)
      if dfs(zs, [x]) or dfs(zs, [{b, a}]) do
        {:halt, true}
      else
        {:cont, false}
      end
    end)
  end
  defp dfs(xs, ys) do
    {c, _} = hd(ys)
    xs
    |> Enum.reduce_while(false, fn {a, b} = x, acc ->
      zs = List.delete(xs, x)
      if b == c and dfs(zs, [x|ys]) or a == c and dfs(zs, [{b, a}|ys]) do
        {:halt, true}
      else
        {:cont, false}
      end
    end)
  end
end

