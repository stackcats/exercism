module LargestSeriesProduct exposing (largestProduct)


chunk : Int -> List Int -> List (List Int)
chunk size list =
    if List.length list <= size then
        [ list ]

    else
        List.take size list :: chunk size (List.drop 1 list)


largestProduct : Int -> String -> Maybe Int
largestProduct length series =
    if length < 1 then
        Nothing

    else if series == "" then
        Nothing

    else if length > String.length series then
        Nothing

    else if String.any (Char.isDigit >> not) series then
        Nothing

    else
        series
            |> String.split ""
            |> List.map (String.toInt >> Maybe.withDefault 0)
            |> chunk length
            |> List.map List.product
            |> List.maximum
