defmodule GuessingGame do
  def compare(secret_number, guess \\ nil)

  def compare(_secret_number, guess) when not is_number(guess) do
    "Make a guess"
  end

  def compare(secret_number, guess) when secret_number == guess do
    "Correct"
  end

  def compare(secret_number, guess) when secret_number > guess + 1 do
    "Too low"
  end

  def compare(secret_number, guess) when secret_number + 1 < guess do
    "Too high"
  end

  def compare(_secret_number, _guess) do
    "So close"
  end
end
