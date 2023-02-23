defmodule FlattenArray do
  @doc """
    Accept a list and return the list flattened without nil values.

    ## Examples

      iex> FlattenArray.flatten([1, [2], 3, nil])
      [1,2,3]

      iex> FlattenArray.flatten([nil, nil])
      []

  """
  @spec flatten(list) :: list
  def flatten([]), do: []

  def flatten([x | xs]) when is_list(x) do
    flatten(x) ++ flatten(xs)
  end

  def flatten([nil | xs]), do: flatten(xs)
  def flatten([x | xs]), do: [x | flatten(xs)]
end
