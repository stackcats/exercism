defmodule BasketballWebsite do
  def extract_from_path(data, path) do
    keys = String.split(path, ".")
    my_get_in(data, keys)
  end

  def my_get_in(nil, _keys), do: nil
  def my_get_in(data, []), do: data

  def my_get_in(data, [k | ks]) do
    my_get_in(data[k], ks)
  end

  def get_in_path(data, path) do
    ps = String.split(path, ".")
    get_in(data, ps)
  end
end
