defmodule Gigasecond do
  @doc """
  Calculate a date one billion seconds after an input date.
  """
  @spec from({{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}) ::
          {{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}
  def from({{year, month, day}, {hours, minutes, seconds}}) do
    {_, date} = Date.new(year, month, day)
    {_, time} = Time.new(hours, minutes, seconds, 0)
    {_, dt} = DateTime.new(date, time)
    dt = DateTime.add(dt, 1000000000)
    {{dt.year, dt.month, dt.day}, {dt.hour, dt.minute, dt.second}}
  end
end

