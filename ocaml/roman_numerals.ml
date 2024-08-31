let to_roman n =
  let mp =
    [
      ("M", 1000);
      ("CM", 900);
      ("D", 500);
      ("CD", 400);
      ("C", 100);
      ("XC", 90);
      ("L", 50);
      ("XL", 40);
      ("X", 10);
      ("IX", 9);
      ("V", 5);
      ("IV", 4);
      ("I", 1);
    ]
  in
  let rec f n s = function
    | [] -> s
    | (c, r) :: _ as t when n >= r -> f (n - r) (s ^ c) t
    | _ :: t -> f n s t
  in
  f n "" mp
