defmodule TwoBucket do
  defstruct [:bucket_one, :bucket_two, :moves]
  @type t :: %TwoBucket{bucket_one: integer, bucket_two: integer, moves: integer}

  @doc """
  Find the quickest way to fill a bucket with some amount of water from two buckets of specific sizes.
  """
  @spec measure(
          size_one :: integer,
          size_two :: integer,
          goal :: integer,
          start_bucket :: :one | :two
        ) :: {:ok, TwoBucket.t()} | {:error, :impossible}
  def measure(size_one, size_two, goal, start_bucket) do
    {{b1, b2}, visited} = if start_bucket == :one do
      {{size_one, 0}, {0, size_two}}
    else
      {{0, size_two}, {size_one, 0}}
    end
    
    :queue.from_list([{b1, b2, 1}])
    |> bfs(MapSet.new([visited]), size_one, size_two, goal)
  end

  defp bfs(q, visited, size_one, size_two, goal) do
    case :queue.out(q) do
      {:empty, _} -> {:error, :impossible}
      {{:value, {b1, b2, ct}}, q} ->
        cond do
          b1 == goal or b2 == goal -> {:ok, %TwoBucket{bucket_one: b1, bucket_two: b2, moves: ct}}
          MapSet.member?(visited, {b1, b2}) -> bfs(q, visited, size_one, size_two, goal)
          true ->
            visited = MapSet.put(visited, {b1, b2})
            b1_to_b2 = min(b1, size_two - b2)
            b2_to_b1 = min(b2, size_one - b1)
            [
              {b1 - b1_to_b2, b2 + b1_to_b2},
              {0, b2},
              {size_one, b2},
              {b1 + b2_to_b1, b2 - b2_to_b1},
              {b1, 0},
              {b1, size_two},
            ]
            |> Enum.reduce(q, fn {b1, b2}, acc ->
              :queue.in({b1, b2, ct + 1}, acc)
            end)
            |> bfs(visited, size_one, size_two, goal)
        end
    end
  end
end

