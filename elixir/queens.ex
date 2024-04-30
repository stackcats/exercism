defmodule Queens do
  @type t :: %Queens{black: {integer, integer}, white: {integer, integer}}
  defstruct [:white, :black]

  defguardp valid(x, y)
    when x >= 0 and x < 8 and y >= 0 and y < 8

  @doc """
  Creates a new set of Queens
  """
  @spec new(Keyword.t()) :: Queens.t()
  def new([white: {x, y}]) when valid(x, y) do
    %Queens{white: {x, y}}
  end

  def new([black: {x, y}]) when valid(x, y) do
    %Queens{black: {x, y}}
  end

  def new([white: {x1, y1}, black: {x2, y2}]) when valid(x1, y1) and valid(x2, y2) and {x1, y1} != {x2, y2} do
    %Queens{white: {x1, y1}, black: {x2, y2}}
  end

  def new(_), do: raise ArgumentError

  @doc """
  Gives a string representation of the board with
  white and black queen locations shown
  """
  @spec to_string(Queens.t()) :: String.t()
  def to_string(%Queens{white: white, black: black}) do
    for i <- 0..7 do
      for j <- 0..7 do
        case {i, j} do
          ^white -> "W"
          ^black -> "B"
          _ -> "_"
        end
      end
      |> Enum.join(" ")
    end
    |> Enum.join("\n")
  end

  @doc """
  Checks if the queens can attack each other
  """
  @spec can_attack?(Queens.t()) :: boolean
  def can_attack?(%Queens{white: {x1, y1}, black: {x2, y2}}) do
    x1 == x2 || y1 == y2 || abs(x1 - x2) == abs(y1 - y2)
  end
  def can_attack?(_), do: false
end

