module PythagoreanTriplet exposing (triplets)


type alias Triplet =
    ( Int, Int, Int )


triplets : Int -> List Triplet
triplets n =
    let
        end =
            n // 3

        loop : Int -> Int -> List Triplet -> List Triplet
        loop a b list =
            if a > end then
                list

            else if b + a > n then
                loop (a + 1) (a + 2) list

            else
                let
                    c =
                        n - a - b
                in
                if a * a + b * b == c * c then
                    loop a (b + 1) (( a, b, c ) :: list)

                else
                    loop a (b + 1) list
    in
    loop 1 2 [] |> List.reverse
