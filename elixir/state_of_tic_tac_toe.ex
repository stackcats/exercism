defmodule StateOfTicTacToe do
  @doc """
  Determine the state a game of tic-tac-toe where X starts.
  """
  @spec game_state(board :: String.t()) :: {:ok, :win | :ongoing | :draw} | {:error, String.t()}
  def game_state(board) do
    board =
      board
      |> String.split("\n")
      |> Enum.with_index()
      |> Enum.reduce(%{}, fn {r, i}, acc ->
        r
        |> String.graphemes()
        |> Enum.with_index()
        |> Enum.reduce(acc, fn {c, j}, acc ->
          Map.put(acc, {i, j}, c)
        end)
      end)

    xs = Enum.count(board, fn {_, v} -> v == "X" end)
    os = Enum.count(board, fn {_, v} -> v == "O" end)
    x? = check_winner(board, "X")
    o? = check_winner(board, "O")

    cond do
      x? and o? -> {:error, "Impossible board: game should have ended after the game was won"}
      os > xs -> {:error, "Wrong turn order: O started"}
      xs - os > 1 -> {:error, "Wrong turn order: X went twice"}
      x? or o? -> {:ok, :win}
      xs + os == 9 -> {:ok, :draw}
      true -> {:ok, :ongoing}
    end
  end

  defp check_winner(board, t) do
    Enum.any?(0..2, fn i ->
      Enum.all?(0..2, fn j -> board[{i, j}] == t end)
    end) or
      Enum.any?(0..2, fn j ->
        Enum.all?(0..2, fn i -> board[{i, j}] == t end)
      end) or
      Enum.all?(0..2, fn i -> board[{i, i}] == t end) or
      Enum.all?(0..2, fn i -> board[{i, 2 - i}] == t end)
  end
end
