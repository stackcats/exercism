defmodule Lasagna do
  def expected_minutes_in_oven(), do: 40

  def remaining_minutes_in_oven(m) do
    expected_minutes_in_oven() - m
  end

  def preparation_time_in_minutes(m), do: m * 2

  def total_time_in_minutes(m, n) do
    preparation_time_in_minutes(m) + n
  end

  def alarm(), do: "Ding!"
end
