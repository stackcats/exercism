defmodule Username do
  def sanitize(username) do
    username
    |> Enum.flat_map(fn c ->
      case c do
        ?ä -> 'ae'
        ?ö -> 'oe'
        ?ü -> 'ue'
        ?ß -> 'ss'
        ?_ -> '_'
        c when c in ?a..?z -> [c]
        _ -> []
      end
    end)
  end
end
