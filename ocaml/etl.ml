let transform lst =
  lst
  |> List.map (fun (n, cs) ->
         List.map (fun c -> (Char.lowercase_ascii c, n)) cs)
  |> List.flatten |> List.sort compare
