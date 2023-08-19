module PascalsTriangle exposing (rows)


next : List Int -> List Int
next list =
    case list of
        [] ->
            []

        [ x ] ->
            [ x ]

        x :: y :: xs ->
            (x + y) :: next (y :: xs)


aux : Int -> List (List Int)
aux n =
    case n of
        0 ->
            []

        1 ->
            [ [ 1 ] ]

        _ ->
            let
                lst =
                    aux (n - 1)

                x =
                    List.head lst |> Maybe.withDefault []
            in
            List.concat [ [ 1 ], next x ] :: lst


rows : Int -> List (List Int)
rows n =
    if n <= 0 then
        []

    else
        aux n |> List.reverse
