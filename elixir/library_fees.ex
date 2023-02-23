defmodule LibraryFees do
  def datetime_from_string(string) do
    NaiveDateTime.from_iso8601(string) |> elem(1)
  end

  def before_noon?(datetime) do
    datetime.hour < 12
  end

  def return_date(checkout_datetime) do
    d = if before_noon?(checkout_datetime), do: 28, else: 29

    NaiveDateTime.add(checkout_datetime, d, :day)
    |> NaiveDateTime.to_date()
  end

  def days_late(planned_return_date, actual_return_datetime) do
    actual_return_datetime
    |> NaiveDateTime.to_date()
    |> Date.diff(planned_return_date)
    |> max(0)
  end

  def monday?(datetime) do
    datetime |> NaiveDateTime.to_date() |> Date.day_of_week() |> then(&(&1 == 1))
  end

  def calculate_late_fee(checkout, return, rate) do
    ret_dt = datetime_from_string(return)

    days =
      checkout
      |> datetime_from_string()
      |> return_date()
      |> days_late(ret_dt)

    if monday?(ret_dt) do
      floor(days * rate * 0.5)
    else
      days * rate
    end
  end
end
