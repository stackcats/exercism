open Base

type player = O | X

let check board target =
  let row = Array.length board
  and col = Array.length board.(0)
  and q = Queue.create ()
  and seen = Hash_set.Poly.create () in
  let is_win (i, j) =
    match target with
    | 'X' -> j = col - 1
    | 'O' -> i = row - 1
    | _ -> failwith "error"
  in
  let rec bfs () =
    match Queue.dequeue q with
    | None -> false
    | Some (i, j) ->
        if Hash_set.Poly.mem seen (i, j) then bfs ()
        else if is_win (i, j) then true
        else (
          Hash_set.Poly.add seen (i, j);
          [
            (i, j + 1);
            (i - 1, j);
            (i, j - 1);
            (i + 1, j);
            (i + 1, j - 1);
            (i - 1, j + 1);
          ]
          |> List.iter ~f:(fun (ni, nj) ->
                 if
                   ni >= 0
                   && ni < row
                   && nj >= 0
                   && nj < col
                   && Char.(board.(ni).(nj) = target)
                 then Queue.enqueue q (ni, nj));
          bfs ())
  in
  Char.(
    if target = 'X' then
      for i = 0 to row - 1 do
        if board.(i).(0) = target then Queue.enqueue q (i, 0)
      done
    else
      for j = 0 to col - 1 do
        if board.(0).(j) = target then Queue.enqueue q (0, j)
      done);
  bfs ()

let connect lst =
  let board =
    List.map lst ~f:(fun s ->
        String.to_list s
        |> List.filter ~f:(fun c -> Char.(c <> ' '))
        |> Array.of_list)
    |> Array.of_list
  in
  if check board 'X' then Some X else if check board 'O' then Some O else None
