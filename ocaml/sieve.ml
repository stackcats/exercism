open Base

let primes n =
  let rec p = function
    | [] -> []
    | x :: xs -> x :: p (List.filter ~f:(fun y -> y % x <> 0) xs)
  in
  p @@ List.range ~stop:`inclusive 2 n
