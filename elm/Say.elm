module Say exposing (SayError(..), say)


type SayError
    = Negative
    | TooLarge


mapping : List ( Int, String )
mapping =
    [ ( 1000000000, "billion" )
    , ( 1000000, "million" )
    , ( 1000, "thousand" )
    , ( 100, "hundred" )
    , ( 90, "ninety" )
    , ( 80, "eighty" )
    , ( 70, "seventy" )
    , ( 60, "sixty" )
    , ( 50, "fifty" )
    , ( 40, "forty" )
    , ( 30, "thirty" )
    , ( 20, "twenty" )
    , ( 19, "nineteen" )
    , ( 18, "eighteen" )
    , ( 17, "seventeen" )
    , ( 16, "sixteen" )
    , ( 15, "fifteen" )
    , ( 14, "fourteen" )
    , ( 13, "thirteen" )
    , ( 12, "twelve" )
    , ( 11, "eleven" )
    , ( 10, "ten" )
    , ( 9, "nine" )
    , ( 8, "eight" )
    , ( 7, "seven" )
    , ( 6, "six" )
    , ( 5, "five" )
    , ( 4, "four" )
    , ( 3, "three" )
    , ( 2, "two" )
    , ( 1, "one" )
    ]


aux : Int -> String
aux n =
    let
        m =
            List.filter (Tuple.first >> (>=) n) mapping
    in
    case m of
        [] ->
            ""

        ( v, s ) :: _ ->
            let
                rem =
                    n // v

                mod =
                    modBy v n

                t1 =
                    s

                t2 =
                    if n >= 100 && rem > 0 then
                        aux rem ++ " " ++ t1

                    else
                        t1

                t3 =
                    if n >= 100 && mod > 0 && mod < 100 then
                        t2 ++ " and"

                    else
                        t2

                t4 =
                    if n < 100 && n >= 20 && mod > 0 then
                        t3 ++ "-" ++ aux mod

                    else if mod > 0 then
                        t3 ++ " " ++ aux mod

                    else
                        t3
            in
            t4


say : Int -> Result SayError String
say number =
    if number < 0 then
        Err Negative

    else if number > 999999999999 then
        Err TooLarge

    else if number == 0 then
        Ok "zero"

    else
        aux number |> String.trim |> Ok
