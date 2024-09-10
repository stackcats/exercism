open Base

let make_change ~target ~coins =
  if target < 0 then Error "target can't be negative"
  else if target = 0 then Ok []
  else
    let dp = Array.create ~len:(target + 1) (target + 1) in
    let change_coins = Array.create ~len:(target + 1) [] in
    dp.(0) <- 0;
    for amount = 1 to target do
      List.iter coins ~f:(fun c ->
          if amount - c >= 0 && dp.(amount - c) + 1 < dp.(amount) then (
            dp.(amount) <- dp.(amount - c) + 1;
            change_coins.(amount) <- c :: change_coins.(amount - c)))
    done;
    match change_coins.(target) with
    | [] -> Error "can't make target with given coins"
    | lst -> Ok lst
