defmodule SgfParsing do
  defmodule Sgf do
    defstruct properties: %{}, children: []
  end

  @type sgf :: %Sgf{properties: map, children: [sgf]}

  @doc """
  Parse a string into a Smart Game Format tree
  """
  @spec parse(encoded :: String.t()) :: {:ok, sgf} | {:error, String.t()}
  def parse(encoded) do
    try do
      encoded
      |> String.graphemes()
      |> parse_tree()
      |> then(&{:ok, &1})
    rescue
      err -> {:error, err.message}
    end
  end

  defp parse_tree(token) do
    if not match?(["(" | _], token) do
      raise "tree missing"
    end

    token
    |> parse_node()
    |> elem(1)
  end

  defp parse_node(token) do
    token = if match?(["(" | _], token), do: tl(token), else: token

    if match?([")" | _], token) do
      raise "tree with no nodes"
    end

    # skip ;
    token = tl(token)

    {token, properties} = parse_properties(token, %{})

    {token, children} = parse_children(token, [])

    {token, %Sgf{properties: properties, children: children}}
  end

  defp parse_children([], children), do: {[], children}
  defp parse_children([")" | rest], children), do: {rest, children}

  defp parse_children(token, children) do
    {token, node} = parse_node(token)
    parse_children(token, children ++ [node])
  end

  defp parse_properties([], _), do: raise("invalid tree")

  defp parse_properties(token, properties) when hd(token) not in ["(", ";", ")"] do
    {token, property} = parse_property(token)
    parse_properties(token, Map.merge(properties, property))
  end

  defp parse_properties(token, properties), do: {token, properties}

  defp parse_property(token) do
    {token, key} = parse_property_key(token)

    if not match?(["[" | _], token) do
      raise "properties without delimiter"
    end

    {token, values} = parse_property_values(token, [])

    {token, %{key => values}}
  end

  defp parse_property_key(token) do
    {lft, rht} = Enum.split_while(token, &(&1 != "["))

    if Enum.any?(lft, fn t -> String.upcase(t) != t end) do
      raise "property must be in uppercase"
    end

    {rht, Enum.join(lft)}
  end

  defp parse_property_values([], _), do: raise("invalid tree")

  defp parse_property_values(["[" | rest], values) do
    {token, value} = parse_property_value(rest, "")
    parse_property_values(token, values ++ [value])
  end

  defp parse_property_values(token, values), do: {token, values}

  defp parse_property_value([], _), do: raise("invalid tree")
  defp parse_property_value(["]" | rest], value), do: {rest, value}

  defp parse_property_value([t | rest], value) do
    case t do
      "\t" ->
        parse_property_value(rest, value <> " ")

      "\\" ->
        case rest do
          [] -> parse_property_value(rest, value <> t)
          ["\n" | rest] -> parse_property_value(rest, value)
          ["\t" | rest] -> parse_property_value(rest, value <> " ")
          [t2 | rest] -> parse_property_value(rest, value <> t2)
        end

      _ ->
        parse_property_value(rest, value <> t)
    end
  end
end
