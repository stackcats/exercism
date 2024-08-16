type item = { weight : int; value : int }

let maximum_value (items : item list) (capacity : int) : int =
  let dp = Array.make (capacity + 1) 0 in
  List.iter
    (fun { weight; value } ->
      for i = capacity downto weight do
        dp.(i) <- max (dp.(i - weight) + value) dp.(i)
      done)
    items;
  dp.(capacity)
