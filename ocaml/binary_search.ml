open Base

let find arr target =
  let rec find' i j =
    if i > j then Error "value not in array"
    else
      let mid = i + ((j - i) / 2) in
      if arr.(mid) = target then Ok mid
      else if arr.(mid) < target then find' (mid + 1) j
      else find' i (mid - 1)
  in
  find' 0 @@ (Array.length arr - 1)
