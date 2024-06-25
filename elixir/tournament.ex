defmodule Tournament do
  @header "Team                           | MP |  W |  D |  L |  P"

  @doc """
  Given `input` lines representing two teams and whether the first of them won,
  lost, or reached a draw, separated by semicolons, calculate the statistics
  for each team's number of games played, won, drawn, lost, and total points
  for the season, and return a nicely-formatted string table.

  A win earns a team 3 points, a draw earns 1 point, and a loss earns nothing.

  Order the outcome by most total points for the season, and settle ties by
  listing the teams in alphabetical order.
  """
  @spec tally(input :: list(String.t())) :: String.t()
  def tally(input) do
    input
    |> Enum.filter(fn s ->
      s =~ ~r/^.*;.*;(win|draw|loss)$/
    end)
    |> Enum.reduce(%{}, fn s, acc ->
      [a, b, res] = String.split(s, ";")

      case res do
        "win" -> {[1, 1, 0, 0], [1, 0, 0, 1]}
        "loss" -> {[1, 0, 0, 1], [1, 1, 0, 0]}
        "draw" -> {[1, 0, 1, 0], [1, 0, 1, 0]}
      end
      |> then(fn {r1, r2} ->
        acc
        |> Map.update(a, r1, &add(&1, r1))
        |> Map.update(b, r2, &add(&1, r2))
      end)
    end)
    |> Enum.sort_by(fn {k, v} -> {-calc(v), k} end)
    |> Enum.map(fn {k, v} ->
      [mp, w, d, l, p] =
        (v ++ [calc(v)])
        |> Enum.map(fn n ->
          String.pad_leading("#{n}", 3)
        end)

      "#{String.pad_trailing(k, 31)}|#{mp} |#{w} |#{d} |#{l} |#{p}"
    end)
    |> then(&[@header | &1])
    |> Enum.join("\n")
  end

  defp add(xs, ys) do
    Enum.zip(xs, ys)
    |> Enum.map(fn {x, y} -> x + y end)
  end

  defp calc([_mp, w, d, _l]) do
    w * 3 + d * 1
  end
end
