module AllYourBase exposing (rebase)


toBase : Int -> Int -> List Int -> List Int
toBase n base digits =
    if n == 0 then
        digits

    else
        toBase (n // base) base (modBy base n :: digits)


rebase : Int -> List Int -> Int -> Maybe (List Int)
rebase inBase digits outBase =
    if digits == [] then
        Nothing

    else if inBase < 2 then
        Nothing

    else if outBase < 2 then
        Nothing

    else if List.any (\d -> d < 0 || d >= inBase) digits then
        Nothing

    else
        let
            n =
                List.foldl (\d acc -> acc * inBase + d) 0 digits
        in
        if n == 0 then
            Nothing

        else
            toBase n outBase [] |> Just
