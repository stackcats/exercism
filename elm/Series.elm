module Series exposing (slices)


slices : Int -> String -> Result String (List (List Int))
slices size input =
    let
        aux : List Int -> List (List Int)
        aux list =
            if List.length list < size then
                []

            else
                List.take size list :: aux (List.drop 1 list)
    in
    if size == 0 then
        Err "slice length cannot be zero"

    else if size < 0 then
        Err "slice length cannot be negative"

    else if input == "" then
        Err "series cannot be empty"

    else if size > String.length input then
        Err "slice length cannot be greater than series length"

    else
        input
            |> String.split ""
            |> List.map (String.toInt >> Maybe.withDefault 0)
            |> aux
            |> Ok
