module BinarySearch exposing (find)

import Array exposing (Array)


find : Int -> Array Int -> Maybe Int
find target xs =
    let
        f : Int -> Int -> Maybe Int
        f l r =
            if l > r then
                Nothing

            else
                let
                    m =
                        l + (r - l) // 2

                    v =
                        Array.get m xs |> Maybe.withDefault 0
                in
                if v == target then
                    Just m

                else if v < target then
                    f (m + 1) r

                else
                    f l (r - 1)
    in
    if Array.isEmpty xs then
        Nothing

    else
        f 0 (Array.length xs - 1)
