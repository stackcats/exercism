type planet =
  | Mercury
  | Venus
  | Earth
  | Mars
  | Jupiter
  | Saturn
  | Neptune
  | Uranus

let age_on planet snds =
  let y = float_of_int snds /. 31557600.
  and lst =
    [
      (Mercury, 0.2408467);
      (Venus, 0.61519726);
      (Earth, 1.);
      (Mars, 1.8808158);
      (Jupiter, 11.862615);
      (Saturn, 29.447498);
      (Neptune, 164.79132);
      (Uranus, 84.016846);
    ]
  in
  List.assoc planet lst |> ( /. ) y
