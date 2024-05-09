defmodule RobotSimulator do
  @type robot() :: any()
  @type direction() :: :north | :east | :south | :west
  @type position() :: {integer(), integer()}

  @directions [:north, :east, :south, :west]
  defguardp is_direction(d) when d in @directions

  defguardp is_position(x, y) when is_integer(x) and is_integer(y)

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction, position) :: robot() | {:error, String.t()}
  def create(direction \\ :north, position \\ {0, 0})
  def create(direction, _) when not is_direction(direction) do
    {:error, "invalid direction"}
  end
  def create(direction, {x, y} = position) when is_direction(direction) and is_position(x, y) do
    {direction, position}
  end
  def create(_, _), do: {:error, "invalid position"}

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot, instructions :: String.t()) :: robot() | {:error, String.t()}
  def simulate(robot, instructions) do
    instructions
    |> String.graphemes()
    |> Enum.reduce_while(robot, fn ins, {dir, pos} ->
      case ins do
        "A" -> {:cont, {dir, advance(pos, dir)}}
        "R" -> {:cont, {turn(dir, "R"), pos}}
        "L" -> {:cont, {turn(dir, "L"), pos}}
        _ -> {:halt, {:error, "invalid instruction"}}
      end
    end)
  end

  defp advance({x, y}, :north), do: {x, y + 1}
  defp advance({x, y}, :east), do: {x + 1, y}
  defp advance({x, y}, :south), do: {x, y - 1}
  defp advance({x, y}, :west), do: {x - 1, y}

  defp turn(curr, dir) do
    i = Enum.find_index(@directions, &(&1 == curr))
    case dir do
      "R" -> Enum.at(@directions, rem(i + 1, 4))
      "L" -> Enum.at(@directions, rem(i - 1 + 4, 4))
    end
  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot) :: direction()
  def direction(robot) do
    elem(robot, 0)
  end

  @doc """
  Return the robot's position.
  """
  @spec position(robot) :: position()
  def position(robot) do
    elem(robot, 1)
  end
end

