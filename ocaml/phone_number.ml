open Base

let check s =
  if Char.equal s.[0] '0' then Error "area code cannot start with zero"
  else if Char.equal s.[0] '1' then Error "area code cannot start with one"
  else if Char.equal s.[3] '0' then Error "exchange code cannot start with zero"
  else if Char.equal s.[3] '1' then Error "exchange code cannot start with one"
  else Ok s

let number s =
  let is_valid = String.contains "+-.() 0123456789" in
  if String.exists s ~f:Char.is_alpha then Error "letters not permitted"
  else if String.exists s ~f:(Fn.compose not is_valid) then
    Error "punctuations not permitted"
  else
    let t = String.filter s ~f:Char.is_digit in
    match String.length t with
    | len when len > 11 -> Error "more than 11 digits"
    | 10 -> check t
    | 11 when Char.equal t.[0] '1' -> check @@ String.drop_prefix t 1
    | 11 -> Error "11 digits must start with 1"
    | _ -> Error "incorrect number of digits"
