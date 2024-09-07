open Base

type word = Reserved of (int list -> int list) | UserDefined of string list
type env = { st : int list; words : (string * word) list }

let add st =
  let (a :: b :: rs) = st in
  (a + b) :: rs

let sub st =
  let (a :: b :: rs) = st in
  (b - a) :: rs

let mul st =
  let (a :: b :: rs) = st in
  (b * a) :: rs

let div st =
  let (a :: b :: rs) = st in
  (b / a) :: rs

let dup st =
  let (a :: rs) = st in
  a :: a :: rs

let drop st =
  let (_ :: rs) = st in
  rs

let swap st =
  let (a :: b :: rs) = st in
  b :: a :: rs

let over st =
  let (a :: b :: rs) = st in
  b :: a :: b :: rs

let prelude =
  [
    ("+", Reserved add);
    ("-", Reserved sub);
    ("*", Reserved mul);
    ("/", Reserved div);
    ("dup", Reserved dup);
    ("drop", Reserved drop);
    ("swap", Reserved swap);
    ("over", Reserved over);
  ]

let is_number = Fn.compose Option.is_some Int.of_string_opt

let define_word s words =
  let (w :: xs) =
    s
    |> String.strip ~drop:(fun c -> Char.(c = ';' || c = ':' || c = ' '))
    |> String.split ~on:' '
  in
  if is_number w then failwith "cannot redefine numbers"
  else
    List.map xs ~f:(fun x ->
        if is_number x then [ x ]
        else
          match List.Assoc.find_exn words ~equal:String.equal x with
          | Reserved f -> [ x ]
          | UserDefined lst -> lst)
    |> List.concat
    |> function
    | lst -> List.Assoc.add words ~equal:String.equal w (UserDefined lst)

let rec eval_word s env =
  match List.Assoc.find_exn env.words ~equal:String.equal s with
  | Reserved f -> { env with st = f env.st }
  | UserDefined lst -> eval env (String.concat ~sep:" " lst)

and eval env s =
  let s = String.lowercase s in
  if String.is_prefix ~prefix:":" s then
    { env with words = define_word s env.words }
  else
    s
    |> String.split ~on:' '
    |> List.fold_left ~init:env ~f:(fun acc x ->
           if is_number x then { acc with st = Int.of_string x :: acc.st }
           else if List.Assoc.mem acc.words ~equal:String.equal x then
             eval_word x acc
           else failwith @@ "undefined word" ^ x)

let evaluate lst =
  try
    let env = List.fold_left lst ~init:{ st = []; words = prelude } ~f:eval in
    Some (List.rev env.st)
  with _ -> None
