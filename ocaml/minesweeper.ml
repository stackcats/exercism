open Base

let ns =
  [ (-1, -1); (-1, 0); (-1, 1); (0, 1); (1, 1); (1, 0); (1, -1); (0, -1) ]

let aux mat =
  let row = Array.length mat and col = Array.length mat.(0) in
  for i = 0 to row - 1 do
    for j = 0 to col - 1 do
      if Char.(mat.(i).(j) = ' ') then
        let ct =
          List.count ns ~f:(fun (di, dj) ->
              let ni = i + di and nj = j + dj in
              ni >= 0
              && nj >= 0
              && ni < row
              && nj < col
              && Char.(mat.(ni).(nj) = '*'))
        in
        if ct <> 0 then mat.(i).(j) <- Char.of_int_exn (ct + Char.to_int '0')
    done
  done;
  mat

let annotate = function
  | [] -> []
  | lst ->
      lst
      |> List.map ~f:String.to_array
      |> List.to_array
      |> aux
      |> Array.map ~f:String.of_array
      |> Array.to_list
