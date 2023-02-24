defmodule MatchingBrackets do
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t()) :: boolean
  def check_brackets(str) do
    mp = %{")" => "(", "]" => "[", "}" => "{"}

    str
    |> String.graphemes()
    |> Enum.reduce_while({true, []}, fn c, {acc, st} ->
      cond do
        c in ["[", "{", "("] ->
          {:cont, {acc, [c | st]}}

        c in ["]", "}", ")"] ->
          if st == [] or hd(st) != mp[c] do
            {:halt, {false, []}}
          else
            {:cont, {acc, tl(st)}}
          end

        true ->
          {:cont, {acc, st}}
      end
    end)
    |> then(fn {bool, st} -> bool && st == [] end)
  end
end
