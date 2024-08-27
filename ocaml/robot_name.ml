open Base

type robot = { mutable name : string }

let exist_names = ref (Set.empty (module String))

let random_name () =
  let generate (n, c) = Char.of_int_exn (Random.int n + Char.to_int c) in
  [ (26, 'A'); (26, 'A'); (10, '0'); (10, '0'); (10, '0') ]
  |> List.map ~f:generate
  |> String.of_char_list

let rec new_name () =
  let name = random_name () in
  if Set.mem !exist_names name then new_name ()
  else (
    exist_names := Set.add !exist_names name;
    name)

let new_robot () = { name = new_name () }
let name robot = robot.name

let reset robot =
  exist_names := Set.remove !exist_names robot.name;
  robot.name <- new_name ()
