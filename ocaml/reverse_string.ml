let reverse_string s =
  s |> String.to_seq
  |> Seq.fold_left (fun acc c -> c :: acc) []
  |> List.to_seq |> String.of_seq
