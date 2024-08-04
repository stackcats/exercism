open Base

let sort s =
  let lst = String.to_list s in
  List.sort lst Char.compare |> String.of_list

let anagrams s lst =
  let s = String.lowercase s in
  let ss = sort s in
  List.filter
    ~f:(fun t ->
      let t = String.lowercase t in
      let tt = sort t in
      (not (String.equal s t)) && String.equal ss tt)
    lst
