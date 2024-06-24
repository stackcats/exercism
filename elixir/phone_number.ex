defmodule PhoneNumber do
  @doc """
  Remove formatting from a phone number if the given number is valid. Return an error otherwise.
  """
  @spec clean(String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def clean(raw) do
    s = String.replace(raw, ~r/[^0-9]/, "")
    len = String.length(s)

    cond do
      Regex.match?(~r/[^0-9()-. ]/, raw) -> {:error, "must contain digits only"}
      len < 10 -> {:error, "must not be fewer than 10 digits"}
      len == 11 and String.starts_with?(s, "1") -> String.slice(s, 1, 10) |> do_clean()
      len == 11 -> {:error, "11 digits must start with 1"}
      len > 11 -> {:error, "must not be greater than 11 digits"}
      true -> do_clean(s)
    end
  end

  defp do_clean(s) do
    cond do
      Regex.match?(~r/^0/, s) -> {:error, "area code cannot start with zero"}
      Regex.match?(~r/^1/, s) -> {:error, "area code cannot start with one"}
      Regex.match?(~r/^...0/, s) -> {:error, "exchange code cannot start with zero"}
      Regex.match?(~r/^...1/, s) -> {:error, "exchange code cannot start with one"}
      true -> {:ok, s}
    end
  end
end
