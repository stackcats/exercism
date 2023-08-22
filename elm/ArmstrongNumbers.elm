module ArmstrongNumbers exposing (isArmstrongNumber)


isArmstrongNumber : Int -> Bool
isArmstrongNumber nb =
    let
        numberToDigits : Int -> List Int
        numberToDigits n =
            if n == 0 then
                []

            else
                modBy 10 n :: numberToDigits (n // 10)

        p =
            String.fromInt nb |> String.length
    in
    numberToDigits nb
        |> List.foldl (\n acc -> acc + n ^ p) 0
        |> (==) nb
