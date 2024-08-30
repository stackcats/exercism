open React

type progress = Win | Lose | Busy of int

type t = {
  progress : progress signal;
  fn : progress -> unit;
  word : string;
  mutable guessed : char list;
}

let create word =
  let p, fn = S.create (Busy 9) in
  { progress = p; fn; word; guessed = [] }

let feed c hm =
  if String.contains hm.word c && not (List.mem c hm.guessed) then (
    hm.guessed <- c :: hm.guessed;
    if String.for_all (fun c -> List.mem c hm.guessed) hm.word then hm.fn Win)
  else
    match S.value hm.progress with
    | Busy n when n = 0 -> hm.fn Lose
    | Busy n -> hm.fn (Busy (n - 1))
    | _ -> failwith "game ending"

let masked_word hm =
  hm.word
  |> String.map (fun c -> if List.mem c hm.guessed then c else '_')
  |> S.create
  |> fst

let progress hm = hm.progress
