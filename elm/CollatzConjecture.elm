module CollatzConjecture exposing (collatz)


collatz : Int -> Result String Int
collatz start =
    let
        f : Int -> Int -> Int
        f n acc =
            if n == 1 then
                acc

            else if modBy 2 n == 0 then
                f (n // 2) (acc + 1)

            else
                f (n * 3 + 1) (acc + 1)
    in
    if start <= 0 then
        Err "Only positive integers are allowed"

    else
        f start 0 |> Ok
