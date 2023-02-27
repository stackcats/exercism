defmodule BinarySearch do
  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """

  @spec search(tuple, integer) :: {:ok, integer} | :not_found
  def search(numbers, key) do
    search(numbers, key, 0, tuple_size(numbers) - 1)
  end

  def search(_numbers, _key, left, right) when left > right do
    :not_found
  end

  def search(numbers, key, left, right) do
    mid = left + div(right - left, 2)
    target = elem(numbers, mid)

    cond do
      target == key -> {:ok, mid}
      target < key -> search(numbers, key, mid + 1, right)
      true -> search(numbers, key, left, mid - 1)
    end
  end
end
