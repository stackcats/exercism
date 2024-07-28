type nucleotide = A | C | G | T

let hamming_distance a b =
  match (a, b) with
  | [], [] -> Ok 0
  | [], _ -> Error "left strand must not be empty"
  | _, [] -> Error "right strand must not be empty"
  | _ ->
      if List.length a <> List.length b then
        Error "left and right strands must be of equal length"
      else
        Ok (List.fold_left2 (fun acc a b -> acc + if a = b then 0 else 1) 0 a b)
