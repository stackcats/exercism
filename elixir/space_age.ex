defmodule SpaceAge do
  @days 365.25
  @type planet ::
          :mercury
          | :venus
          | :earth
          | :mars
          | :jupiter
          | :saturn
          | :uranus
          | :neptune
  @doc """
  Return the number of years a person that has lived for 'seconds' seconds is
  aged on 'planet', or an error if 'planet' is not a planet.
  """
  @spec age_on(planet, pos_integer) :: {:ok, float} | {:error, String.t()}
  def age_on(planet, seconds) do
    case planet do
      :mercury -> 0.2408467
      :venus -> 0.61519726
      :earth -> 1
      :mars -> 1.8808158
      :jupiter -> 11.862615
      :saturn -> 29.447498
      :uranus -> 84.016846
      :neptune -> 164.79132
      _ -> -1
    end
    |> then(fn x ->
      if x == -1, do: {:error, "not a planet"}, else: {:ok, seconds / x / 3600 / 24 / @days}
    end)
  end
end
