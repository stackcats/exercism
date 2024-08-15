let factors_of n =
  let rec f fac n =
    if fac > n then []
    else if Int64.rem n fac = 0L then fac :: f fac (Int64.div n fac)
    else f (Int64.add fac 1L) n
  in
  f 2L n
