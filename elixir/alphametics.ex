defmodule Alphametics do
  @type puzzle :: binary
  @type solution :: %{required(?A..?Z) => 0..9}

  @doc """
  Takes an alphametics puzzle and returns a solution where every letter
  replaced by its number will make a valid equation. Returns `nil` when
  there is no valid solution to the given puzzle.

  ## Examples

    iex> Alphametics.solve("I + BB == ILL")
    %{?I => 1, ?B => 9, ?L => 0}

    iex> Alphametics.solve("A == B")
    nil
  """
  @spec solve(puzzle) :: solution | nil
  def solve(puzzle) do
    cs = puzzle 
      |> String.replace(~r/[^A-Z]/, "") 
      |> String.to_charlist()
      |> Enum.uniq()
      |> Enum.sort()

    [args, res] = String.split(puzzle, " == ")
    args = String.split(args, " + ")

    permutations(0..9, length(cs))
    |> Enum.reduce_while(nil, fn ns, acc ->
      mp = Enum.zip(cs, ns) |> Map.new()
      sum = Enum.reduce_while(args, 0, fn arg, sum ->
          case eval(arg, mp) do
            nil -> {:halt, nil}
            n -> {:cont, sum + n}
          end
        end)

      if sum != nil and sum == eval(res, mp) do
        {:halt, mp}
      else
        {:cont, acc}
      end
    end)
  end

  defp eval(cs, mp) do
    cs = String.to_charlist(cs)
    if mp[hd(cs)] == 0 do
      nil
    else
      cs |> Enum.reduce(0, fn c, acc -> mp[c] + acc * 10 end)
    end
  end
  
  defp permutations(lst, n, visited \\ %MapSet{}, curr \\ [], res \\ []) do
    if length(curr) == n do
      [curr|res]
    else
      lst
      |> Enum.reduce(res, fn i, acc ->
        if MapSet.member?(visited, i) do
          acc
        else
          permutations(lst, n, MapSet.put(visited, i), [i|curr], acc)
        end
      end)
    end
  end  
end

