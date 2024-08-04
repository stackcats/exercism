open Base

type bst = Nil | Node of int * bst * bst

let empty = Nil
let value = function Nil -> Error "empty" | Node (v, _, _) -> Ok v
let left = function Nil -> Error "empty" | Node (_, l, _) -> Ok l
let right = function Nil -> Error "empty" | Node (_, _, r) -> Ok r

let rec insert n tree =
  match tree with
  | Nil -> Node (n, Nil, Nil)
  | Node (v, l, r) ->
      if v >= n then Node (v, insert n l, r) else Node (v, l, insert n r)

let rec to_list = function
  | Nil -> []
  | Node (v, l, r) -> to_list l @ [ v ] @ to_list r
