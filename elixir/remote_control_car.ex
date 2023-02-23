defmodule RemoteControlCar do
  @enforce_keys [:nickname]
  defstruct battery_percentage: 100, distance_driven_in_meters: 0, nickname: nil

  def new(nickname \\ "none") do
    %RemoteControlCar{nickname: nickname}
  end

  def display_distance(%RemoteControlCar{distance_driven_in_meters: distance_driven_in_meters}) do
    "#{distance_driven_in_meters} meters"
  end

  def display_battery(%RemoteControlCar{battery_percentage: battery_percentage}) do
    if battery_percentage > 0 do
      "Battery at #{battery_percentage}%"
    else
      "Battery empty"
    end
  end

  def drive(
        %RemoteControlCar{
          battery_percentage: battery_percentage,
          distance_driven_in_meters: distance_driven_in_meters,
          nickname: nickname
        } = remote_car
      ) do
    if battery_percentage <= 0 do
      remote_car
    else
      %RemoteControlCar{
        battery_percentage: battery_percentage - 1,
        distance_driven_in_meters: distance_driven_in_meters + 20,
        nickname: nickname
      }
    end
  end
end
