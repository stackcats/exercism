defmodule Bowling do
  import Integer

  @doc """
    Creates a new game of bowling that can be used to store the results of
    the game
  """

  @spec start() :: any
  def start do
    %{}
  end

  @doc """
    Records the number of pins knocked down on a single roll. Returns `any`
    unless there is something wrong with the given number of pins, in which
    case it returns a helpful error tuple.
  """

  @spec roll(any, integer) :: {:ok, any} | {:error, String.t()}
  def roll(game, roll) when roll < 0 do
    {:error, "Negative roll is invalid"}
  end

  def roll(game, roll) when roll > 10 do
    {:error, "Pin count exceeds pins on the lane"}
  end

  def roll(game, roll) do
    size = map_size(game)

    cond do
      size == 20 and game[18] + game[19] != 10 ->
        {:error, "Cannot roll after game is over"}

      size == 21 and game[18] != 10 ->
        {:error, "Cannot roll after game is over"}

      size == 22 and game[20] != 10 ->
        {:error, "Cannot roll after game is over"}

      is_odd(size) and roll + game[size - 1] > 10 ->
        {:error, "Pin count exceeds pins on the lane"}

      roll == 10 ->
        {:ok, add(game, 10) |> add(0)}

      true ->
        {:ok, add(game, roll)}
    end
  end

  @doc """
    Returns the score of a given game of bowling if the game is complete.
    If the game isn't complete, it returns a helpful error tuple.
  """

  @spec score(any) :: {:ok, integer} | {:error, String.t()}
  def score(game) do
    if not over?(game) do
      {:error, "Score cannot be taken until the end of the game"}
    else
      for i <- 0..19//2 do
        cond do
          game[i] == 10 ->
            if game[i + 2] == 10 do
              20 + game[i + 4]
            else
              10 + game[i + 2] + game[i + 3]
            end

          game[i] + game[i + 1] == 10 ->
            10 + game[i + 2]

          true ->
            game[i] + game[i + 1]
        end
      end
      |> Enum.sum()
      |> then(&{:ok, &1})
    end
  end

  defp add(game, roll) do
    Map.put(game, map_size(game), roll)
  end

  defp over?(game) do
    s = map_size(game)

    (s == 24 and game[22] == 10 and game[20] == 10) or
      (s == 23 and game[20] == 10) or
      (s == 22 and
         ((game[18] == 10 and game[20] != 10) or
            (game[18] != 10 and game[18] + game[19] == 10 and game[20] == 10))) or
      (s == 21 and game[18] + game[19] == 10) or
      (s == 20 and game[18] + game[19] != 10)
  end
end
