type palindrome_products = { value : int option; factors : (int * int) list }

let is_palindrome n =
  let k = ref n in
  let p = ref 0 in
  while !k > 0 do
    p := (!p * 10) + (!k mod 10);
    k := !k / 10
  done;
  n = !p

let pick { value; factors } (i, j) check =
  let p = i * j in
  match value with
  | None -> { value = Some p; factors = [ (i, j) ] }
  | Some n when n == p -> { value; factors = factors @ [ (i, j) ] }
  | Some n when check n p -> { value = Some p; factors = [ (i, j) ] }
  | _ -> { value; factors }

let aux ~min ~max ~check =
  if min > max then Error "min must be <= max"
  else
    let r = ref { value = None; factors = [] } in
    for i = min to max do
      for j = i to max do
        if is_palindrome (i * j) then r := pick !r (i, j) check
      done
    done;
    Ok !r

let smallest = aux ~check:( > )
let largest = aux ~check:( < )
