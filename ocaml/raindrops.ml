let raindrop n =
  let f (m, s) = if n mod m = 0 then s else "" in
  let s =
    List.map f [ (3, "Pling"); (5, "Plang"); (7, "Plong") ] |> String.concat ""
  in
  match s with "" -> string_of_int n | _ -> s
