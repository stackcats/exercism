open Base

let valid num =
  let lst =
    num |> String.to_list |> List.filter ~f:(Fn.compose not (Char.equal ' '))
  in
  if List.length lst < 2 then false
  else
    match List.find ~f:(Fn.compose not Char.is_digit) lst with
    | Some _ -> false
    | None ->
        List.rev lst
        |> List.rev_mapi ~f:(fun i n ->
               let n = Char.get_digit_exn n in
               if i % 2 = 1 then
                 let n = n * 2 in
                 if n > 9 then n - 9 else n
               else n)
        |> List.fold_left ~init:0 ~f:( + )
        |> Fn.flip ( % ) 10
        |> ( = ) 0
