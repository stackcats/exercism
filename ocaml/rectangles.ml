let corners mat =
  let lst = ref [] in
  for i = 0 to Array.length mat - 1 do
    for j = 0 to String.length mat.(i) - 1 do
      if mat.(i).[j] = '+' then lst := (i, j) :: !lst
    done
  done;
  !lst |> List.sort compare |> Array.of_list

let is_h (x1, y1) (x2, y2) mat =
  if x1 <> x2 then false
  else
    try
      for y = y1 to y2 do
        if not (String.contains "+-" mat.(x1).[y]) then failwith "false"
      done;
      true
    with _ -> false

let is_v (x1, y1) (x2, y2) mat =
  if y1 <> y2 then false
  else
    try
      for x = x1 to x2 do
        if not (String.contains "+|" mat.(x).[y1]) then failwith "false"
      done;
      true
    with _ -> false

let is_rectangle a b c d mat =
  is_h a b mat && is_h c d mat && is_v a c mat && is_v b d mat

let count_rectangles mat =
  let corners = corners mat in
  let n = Array.length corners - 1 in
  let ct = ref 0 in
  for i = 0 to n do
    for j = i + 1 to n do
      for k = j + 1 to n do
        for l = k + 1 to n do
          if is_rectangle corners.(i) corners.(j) corners.(k) corners.(l) mat
          then ct := !ct + 1
        done
      done
    done
  done;
  !ct
