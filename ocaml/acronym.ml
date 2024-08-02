open Base

let acronym s =
  let prefix = function "" -> None | x -> Some (String.prefix x 1) in
  String.split_on_chars ~on:[ ' '; '-'; '_' ] s
  |> List.filter_map ~f:prefix |> String.concat |> String.uppercase
