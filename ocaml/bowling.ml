open Base

type t = { rolls : int list; frame : int }

let new_game = { rolls = []; frame = 0 }

let last_frame = function
  | [] -> (0, 0)
  | [ a ] -> (a, 0)
  | a :: b :: _ -> (a, b)

let roll r { rolls; frame } =
  match (r, frame, last_frame rolls) with
  | r, _, _ when r < 0 -> Error "Negative roll is invalid"
  | r, _, _ when r > 10 -> Error "Pin count exceeds pins on the lane"
  | r, f, (a, _) when f < 20 && f % 2 = 1 && r + a > 10 ->
      Error "Pin count exceeds pins on the lane"
  | _, 20, (a, b) when a + b < 10 -> Error "Cannot roll after game is over"
  | _, 21, (a, b) when b <> 10 -> Error "Cannot roll after game is over"
  | 10, 21, (a, _) when a <> 10 -> Error "Pin count exceeds pins on the lane"
  | r, 21, (a, 10) when a <> 10 && r + a > 10 ->
      Error "Pin count exceeds pins on the lane"
  | _, 22, _ -> Error "Cannot roll after game is over"
  | 10, f, _ when f < 20 && f % 2 = 0 ->
      Ok { rolls = 10 :: rolls; frame = frame + 2 }
  | _ -> Ok { rolls = r :: rolls; frame = frame + 1 }

let score g =
  let rec score' acc f rolls =
    if f < 10 then
      match rolls with
      | 10 :: (a :: b :: _ as rs) -> score' (acc + 10 + a + b) (f + 1) rs
      | a :: b :: (c :: _ as rs) when a + b = 10 ->
          score' (acc + 10 + c) (f + 1) rs
      | a :: b :: rs when a + b < 10 -> score' (acc + a + b) (f + 1) rs
      | _ -> Error "Score cannot be taken until the end of the game"
    else Ok acc
  in
  List.rev g.rolls |> score' 0 0
