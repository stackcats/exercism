let plural = function 1 -> "" | _ -> "s"

let verse = function
  | 0 ->
      "No more bottles of beer on the wall, no more bottles of beer.\n\
       Go to the store and buy some more, 99 bottles of beer on the wall."
  | 1 ->
      "1 bottle of beer on the wall, 1 bottle of beer.\n\
       Take it down and pass it around, no more bottles of beer on the wall."
  | n ->
      Printf.sprintf
        "%d bottle%s of beer on the wall, %d bottle%s of beer.\n\
         Take one down and pass it around, %d bottle%s of beer on the wall." n
        (plural n) n (plural n) (n - 1)
        (plural @@ (n - 1))

let recite from until =
  List.init until (fun n -> verse (from - n)) |> String.concat "\n\n"
