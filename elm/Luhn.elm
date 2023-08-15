module Luhn exposing (valid)


transform : Int -> Int -> Int
transform n i =
    if modBy 2 i == 0 then
        let
            m =
                n * 2
        in
        if m > 9 then
            m - 9

        else
            m

    else
        n


valid : String -> Bool
valid input =
    let
        code =
            String.reverse input |> String.replace " " ""
    in
    if code == "0" then
        False

    else if String.any (Char.isDigit >> not) code then
        False

    else
        code
            |> String.split ""
            |> List.map (String.toInt >> Maybe.withDefault 0)
            |> List.foldl
                (\n ( acc, i ) ->
                    ( acc + transform n i, i + 1 )
                )
                ( 0, 1 )
            |> Tuple.first
            |> modBy 10
            |> (==) 0
