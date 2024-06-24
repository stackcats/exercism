defmodule Meetup do
  @moduledoc """
  Calculate meetup dates.
  """

  @type weekday ::
          :monday
          | :tuesday
          | :wednesday
          | :thursday
          | :friday
          | :saturday
          | :sunday

  @weekdays [:monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday]

  @type schedule :: :first | :second | :third | :fourth | :last | :teenth

  @doc """
  Calculate a meetup date.

  The schedule is in which week (1..4, last or "teenth") the meetup date should
  fall.
  """
  @spec meetup(pos_integer, pos_integer, weekday, schedule) :: Date.t()
  def meetup(year, month, weekday, schedule) do
    n = Enum.find_index(@weekdays, &(&1 == weekday)) + 1

    Date.new!(year, month, 1)
    |> Stream.unfold(fn
      dt = %Date{month: m} when m == month -> {dt, Date.add(dt, 1)}
      _ -> nil
    end)
    |> Stream.filter(fn dt -> Date.day_of_week(dt) == n end)
    |> then(fn dates ->
      case schedule do
        :first -> Enum.at(dates, 0)
        :second -> Enum.at(dates, 1)
        :third -> Enum.at(dates, 2)
        :fourth -> Enum.at(dates, 3)
        :last -> Enum.to_list(dates) |> List.last()
        _ -> Enum.find(dates, fn dt -> dt.day in 13..19 end)
      end
    end)
  end
end
