module RunLengthEncoding exposing (decode, encode)


encode : String -> String
encode =
    let
        aux : String -> Int -> List String -> List String -> List String
        aux c n arr lst =
            case lst of
                [] ->
                    if n > 1 then
                        c :: String.fromInt n :: arr

                    else
                        c :: arr

                x :: xs ->
                    if x == c then
                        aux c (n + 1) arr xs

                    else if n > 1 then
                        aux x 1 (c :: String.fromInt n :: arr) xs

                    else
                        aux x 1 (c :: arr) xs
    in
    String.split ""
        >> aux "" 1 []
        >> List.reverse
        >> String.concat


decode : String -> String
decode =
    let
        aux : Int -> String -> List String -> String
        aux n ans lst =
            case lst of
                [] ->
                    ans

                x :: xs ->
                    case String.toInt x of
                        Just i ->
                            aux (n * 10 + i) ans xs

                        Nothing ->
                            if n == 0 then
                                aux 0 (ans ++ x) xs

                            else
                                aux 0 (ans ++ String.repeat n x) xs
    in
    String.split ""
        >> aux 0 ""
