defmodule SecretHandshake do
  import Bitwise

  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    ["wink", "double blink", "close your eyes", "jump"]
    |> Enum.reduce({[], 1}, fn cmd, {lst, mask} ->
      lst = if (code &&& mask) > 0, do: [cmd | lst], else: lst
      {lst, mask <<< 1}
    end)
    |> then(fn {lst, mask} ->
      if (code &&& mask) > 0, do: lst, else: Enum.reverse(lst)
    end)
  end
end
