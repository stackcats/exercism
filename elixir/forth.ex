defmodule Forth do
  @opaque evaluator :: any

  @doc """
  Create a new evaluator.
  """
  @spec new() :: evaluator
  def new() do
    words = %{
      "*" => fn
        st when length(st) < 2 -> raise Forth.StackUnderflow
        [a, b | rest] -> [a * b | rest]
      end,
      "+" => fn
        st when length(st) < 2 -> raise Forth.StackUnderflow
        [a, b | rest] -> [a + b | rest]
      end,
      "-" => fn
        st when length(st) < 2 -> raise Forth.StackUnderflow
        [a, b | rest] -> [b - a | rest]
      end,
      "/" => fn
        st when length(st) < 2 -> raise Forth.StackUnderflow
        [0, _] -> raise Forth.DivisionByZero
        [a, b | rest] -> [div(b, a) | rest]
      end,
      "dup" => fn
        [] -> raise Forth.StackUnderflow
        [a | rest] -> [a, a | rest]
      end,
      "drop" => fn
        [] -> raise Forth.StackUnderflow
        [_ | rest] -> rest
      end,
      "swap" => fn
        st when length(st) < 2 -> raise Forth.StackUnderflow
        [a, b | rest] -> [b, a | rest]
      end,
      "over" => fn
        st when length(st) < 2 -> raise Forth.StackUnderflow
        [a, b | rest] -> [b, a, b | rest]
      end
    }

    {[], words}
  end

  @doc """
  Evaluate an input string, updating the evaluator state.
  """
  @spec eval(evaluator, String.t()) :: evaluator
  def eval(ev, s) do
    if String.contains?(s, ";") do
      s
      |> String.split(";")
      |> Enum.reject(&(&1 == ""))
      |> Enum.reduce(ev, &do_eval/2)
    else
      do_eval(s, ev)
    end
  end

  defp do_eval(s, {st, words}) do
    s = normalize(s)

    if String.starts_with?(s, ":") do
      [w | ins] =
        s
        |> String.trim_leading(": ")
        |> String.split(" ")

      if Regex.match?(~r/-?\d/, w) do
        raise Forth.InvalidWord, word: w
      end

      ins =
        Enum.map(ins, fn each ->
          case Integer.parse(each) do
            :error ->
              case words[each] do
                nil -> each
                f when is_function(f) -> each
                x -> x
              end

            {n, _} ->
              n
          end
        end)
        |> Enum.join(" ")

      {st, Map.put(words, w, ins)}
    else
      s
      |> String.split(~r/\s/)
      |> Enum.reduce({st, words}, fn each, {st, words} ->
        case Integer.parse(each) do
          :error -> eval_op(each, {st, words})
          {n, _} -> {[n | st], words}
        end
      end)
    end
  end

  defp eval_op(op, {st, words}) do
    case words[op] do
      n when is_integer(n) -> {[n | st], words}
      nil -> raise Forth.UnknownWord, word: op
      f when is_function(f) -> {f.(st), words}
      s -> do_eval(s, {st, words})
    end
  end

  defp normalize(s) do
    s
    |> String.trim()
    |> String.downcase()
    |> String.replace(~r/[^\\0-\xfe^[:punct:]]+/, " ")
    |> String.replace(" ", "\s")
  end

  @doc """
  Return the current stack as a string with the element on top of the stack
  being the rightmost element in the string.
  """
  @spec format_stack(evaluator) :: String.t()
  def format_stack({st, _words}) do
    st |> Enum.reverse() |> Enum.join(" ")
  end

  defmodule StackUnderflow do
    defexception []
    def message(_), do: "stack underflow"
  end

  defmodule InvalidWord do
    defexception word: nil
    def message(e), do: "invalid word: #{inspect(e.word)}"
  end

  defmodule UnknownWord do
    defexception word: nil
    def message(e), do: "unknown word: #{inspect(e.word)}"
  end

  defmodule DivisionByZero do
    defexception []
    def message(_), do: "division by zero"
  end
end
