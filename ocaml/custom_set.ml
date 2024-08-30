module type ELEMENT = sig
  type t

  val compare : t -> t -> int
end

module Make (El : ELEMENT) = struct
  type t = El.t list
  type el = El.t

  let el_equal a b = compare a b = 0
  let is_empty st = List.is_empty st
  let is_member st el = List.mem el st
  let is_subset s1 s2 = List.for_all (fun el -> is_member s2 el) s1
  let is_disjoint s1 s2 = List.for_all (fun el -> not (is_member s2 el)) s1
  let equal s1 s2 = is_subset s1 s2 && is_subset s2 s1
  let of_list lst = lst
  let add st el = if is_member st el then st else el :: st

  type status = [ `OnlyA | `OnlyB | `Both ]

  let diff_filter _ _ _ = []
  let difference s1 s2 = List.filter (Fun.negate (is_member s2)) s1
  let intersect s1 s2 = List.filter (is_member s2) s1
  let union s1 s2 = List.fold_left add s2 s1
end
