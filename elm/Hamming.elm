module Hamming exposing (distance)


distance : String -> String -> Result String Int
distance left right =
    if String.length left /= String.length right then
        Err "strands must be of equal length"

    else
        List.map2 Tuple.pair (String.toList left) (String.toList right)
            |> List.foldl
                (\( l, r ) acc ->
                    if l == r then
                        acc

                    else
                        1 + acc
                )
                0
            |> Ok
