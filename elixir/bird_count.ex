defmodule BirdCount do
  def today([]), do: nil
  def today([x | _]), do: x

  def increment_day_count([]), do: [1]
  def increment_day_count([x | xs]), do: [x + 1 | xs]

  def has_day_without_birds?([]), do: false
  def has_day_without_birds?([0 | _]), do: true
  def has_day_without_birds?([_ | xs]), do: has_day_without_birds?(xs)

  def total(list, ct \\ 0)
  def total([], ct), do: ct
  def total([x | xs], ct), do: total(xs, ct + x)

  def busy_days(list, ct \\ 0)
  def busy_days([], ct), do: ct
  def busy_days([x | xs], ct) when x >= 5, do: busy_days(xs, ct + 1)
  def busy_days([_ | xs], ct), do: busy_days(xs, ct)
end
