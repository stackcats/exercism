defmodule Wordy do
  @doc """
  Calculate the math problem in the sentence.
  """
  @spec answer(String.t()) :: integer
  def answer(question) do
    question = question |> String.trim("?") |> String.trim("What is")
    ~r/(divided by|multiplied by|minus|plus|-?\d+|\w+)/
      |> Regex.scan(question)
      |> Enum.map(&hd/1)
      |> Enum.reduce({0, "plus", false}, fn input, {acc, op, is_op} ->
        if is_op do
          if Regex.match?(~r/(divided by|multiplied by|minus|plus)/, input) do
            {acc, input, not is_op}
          else
            raise ArgumentError
          end
        else
          n = String.to_integer(input)
          acc = case op do
              "plus" -> acc + n
              "minus" -> acc - n
              "multiplied by" -> acc * n
              "divided by" -> div(acc, n)
              _ -> raise ArgumentError
            end
          {acc, op, not is_op}
        end
      end)
      |> then(fn {acc, _, is_op} ->
        if is_op, do: acc, else: raise ArgumentError
      end)
  end
end

