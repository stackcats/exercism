defmodule TopSecret do
  def to_ast(string) do
    Code.string_to_quoted!(string)
  end

  defp to_name(_name, nil), do: ""
  defp to_name(name, args) do
    name |> Atom.to_string() |> String.slice(0, length(args))
  end

  def decode_secret_message_part({op, _, [{:when, _, [{name, _, args}|_]}|_]} = ast, acc) when op == :def or op == :defp do
    {ast, [to_name(name, args)|acc]}
  end
  def decode_secret_message_part({op, _, [{name, _, args}|_]} = ast, acc) when op == :def or op == :defp do
    {ast, [to_name(name, args)|acc]}
  end
  def decode_secret_message_part(ast, acc), do: {ast, acc}

  def decode_secret_message(string) do
    string
    |> to_ast()
    |> Macro.prewalk([], &decode_secret_message_part/2)
    |> elem(1)
    |> Enum.reverse()
    |> Enum.join()
  end
end

