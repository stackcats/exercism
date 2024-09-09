let rec aux = function
  | 0L -> ""
  | 1L -> "one"
  | 2L -> "two"
  | 3L -> "three"
  | 4L -> "four"
  | 5L -> "five"
  | 6L -> "six"
  | 7L -> "seven"
  | 8L -> "eight"
  | 9L -> "nine"
  | 10L -> "ten"
  | 11L -> "eleven"
  | 12L -> "twelve"
  | 13L -> "thirteen"
  | 14L -> "fourteen"
  | 15L -> "fifteen"
  | 16L -> "sixteen"
  | 17L -> "seventeen"
  | 18L -> "eighteen"
  | 19L -> "nineteen"
  | 20L -> "twenty"
  | 30L -> "thirty"
  | 40L -> "forty"
  | 50L -> "fifty"
  | 60L -> "sixty"
  | 70L -> "seventy"
  | 80L -> "eighty"
  | 90L -> "ninety"
  | n ->
      if n >= 100L then
        let d = Int64.rem n 100L in
        let t = Int64.div n 100L in
        if d = 0L then aux t ^ " hundred" else aux t ^ " hundred " ^ aux d
      else
        let d = Int64.rem n 10L in
        let t = Int64.sub n d in
        if d = 0L then aux t else aux t ^ "-" ^ aux d

let in_english n =
  if n < 0L || n > 999999999999L then Error "input out of range"
  else if n = 0L then Ok "zero"
  else
    [ "billion"; "million"; "thousand" ]
    |> List.fold_left
         (fun (acc, n, r) scale ->
           let d = Int64.div n r
           and n = Int64.rem n r
           and r = Int64.div r 1000L in
           if d > 0L then (scale :: aux d :: acc, n, r) else (acc, n, r))
         ([], n, 1000000000L)
    |> fun (acc, n, _) ->
    aux n :: acc
    |> List.filter (( <> ) "")
    |> List.rev
    |> String.concat " "
    |> Result.ok
