open Base

type from = Left | Right [@@deriving sexp]

type 'a t = {
  focus : 'a;
  left : 'a t option;
  right : 'a t option;
  up : (from * 'a t) option;
}
[@@deriving sexp]

let equal f a b = f a.focus b.focus

let rec of_tree (t : 'a Tree.t) =
  {
    focus = t.value;
    left = Option.map ~f:of_tree t.left;
    right = Option.map ~f:of_tree t.right;
    up = None;
  }

let up z =
  Option.map z.up ~f:(function
    | Left, up' -> { up' with left = Some z }
    | Right, up' -> { up' with right = Some z })

let to_tree z =
  let rec to_root z = match up z with None -> z | Some z -> to_root z in
  let rec to_tree' z : 'a Tree.t =
    {
      value = z.focus;
      left = Option.map z.left ~f:to_tree';
      right = Option.map z.right ~f:to_tree';
    }
  in
  z |> to_root |> to_tree'

let value z = z.focus
let left z = Option.map z.left ~f:(fun lft -> { lft with up = Some (Left, z) })

let right z =
  Option.map z.right ~f:(fun rht -> { rht with up = Some (Right, z) })

let set_value v z = { z with focus = v }
let set_left t z = { z with left = Option.map t ~f:of_tree }
let set_right t z = { z with right = Option.map t ~f:of_tree }
