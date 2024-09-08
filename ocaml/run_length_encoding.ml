open Base

let encode s =
  s
  |> String.to_list
  |> List.group ~break:Char.( <> )
  |> List.map ~f:(fun lst ->
         let c = List.hd_exn lst in
         match List.length lst with
         | 1 -> Printf.sprintf "%c" c
         | n -> Printf.sprintf "%d%c" n c)
  |> String.concat ~sep:""

let repeat c n = List.init n (Fn.const c) |> String.of_list

let decode s =
  s
  |> String.to_list
  |> List.fold_left ~init:(0, "") ~f:(fun (ct, t) c ->
         if Char.is_digit c then ((ct * 10) + Char.get_digit_exn c, t)
         else if ct = 0 then (ct, t ^ Char.to_string c)
         else (0, t ^ repeat c ct))
  |> snd
