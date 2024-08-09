open Base

let empty = Set.empty (module Char)

let is_pangram s =
  String.lowercase s
  |> String.filter ~f:Char.is_alpha
  |> String.fold ~init:empty ~f:Set.add
  |> Set.length |> ( = ) 26
