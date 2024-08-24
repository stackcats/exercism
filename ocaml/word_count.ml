open Base

let empty = Map.empty (module String)
let incr = Map.change ~f:(function None -> Some 1 | Some n -> Some (n + 1))

let word_count s =
  s
  |> String.lowercase
  |> String.split_on_chars ~on:[ ':'; '!'; '?'; '\t'; ' '; '\n'; ',' ]
  |> List.map ~f:(String.strip ~drop:(Fn.non Char.is_alphanum))
  |> List.filter ~f:(Fn.non String.is_empty)
  |> List.fold_left ~init:empty ~f:incr
