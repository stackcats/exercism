open Base

type dominoe = int * int

let rec delete x = function
  | [] -> []
  | h :: t when Stdlib.(h = x) -> t
  | h :: t -> h :: delete x t

let is_chained = function
  | [] -> true
  | (a, _) :: _ as lst ->
      let rec f = function
        | [] -> failwith "unreachable"
        | [ (_, d) ] -> a = d
        | (_, b) :: ((c, d) :: _ as t) when b = c -> f t
        | _ -> false
      in
      f lst

let rec dfs ys = function
  | [] -> Option.some_if (is_chained ys) ys
  | xs ->
      let y = List.hd ys in
      List.fold_until xs ~init:None ~finish:Fn.id ~f:(fun acc (a, b) ->
          let zs = delete (a, b) xs
          and cab = (a, b) :: ys
          and cba = (b, a) :: ys in
          let res =
            match y with
            | None -> Option.first_some (dfs cab zs) (dfs cba zs)
            | Some (c, _) when b = c -> dfs cab zs
            | Some (c, _) when a = c -> dfs cba zs
            | _ -> None
          in
          if Option.is_some res then Stop res else Continue acc)

let chain = dfs []
