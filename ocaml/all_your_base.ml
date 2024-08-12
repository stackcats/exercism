open Base
open Base.Continue_or_stop
open Base.Option

type base = int

let of_digits base =
  List.fold_until ~init:0 ~finish:Option.return ~f:(fun acc d ->
      if d >= 0 && d < base then Continue ((acc * base) + d) else Stop None)

let to_digits target = function
  | 0 -> [ 0 ]
  | n ->
      let rec f lst = function
        | 0 -> lst
        | n -> f ((n % target) :: lst) (n / target)
      in
      f [] n

let convert_bases ~from ~digits ~target =
  if from < 2 || target < 2 then None
  else Some (to_digits target) <*> of_digits from digits
