open Base

let map c = if Char.is_digit c then c else Char.of_int_exn (219 - Char.to_int c)

let encode ?(block_size = 5) s =
  s
  |> String.filter ~f:Char.is_alphanum
  |> String.lowercase
  |> String.to_list
  |> List.map ~f:map
  |> List.chunks_of ~length:block_size
  |> List.map ~f:String.of_list
  |> String.concat ~sep:" "

let decode s = s |> String.filter ~f:Char.is_alphanum |> String.map ~f:map
