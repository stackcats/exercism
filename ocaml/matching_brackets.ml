open Base

let are_balanced s =
  s
  |> String.fold_result ~init:[] ~f:(fun st c ->
         if not @@ String.mem "[]{}()" c then Ok st
         else
           match (st, c) with
           | _, '[' | _, '{' | _, '(' -> Ok (c :: st)
           | '(' :: tl, ')' | '{' :: tl, '}' | '[' :: tl, ']' -> Ok tl
           | _ -> Error "stop")
  |> function
  | Ok st -> List.is_empty st
  | _ -> false
