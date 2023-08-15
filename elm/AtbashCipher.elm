module AtbashCipher exposing (decode, encode)

import Dict exposing (Dict)


plain : String
plain =
    "abcdefghijklmnopqrstuvwxyz"


cipher : String
cipher =
    "zyxwvutsrqponmlkjihgfedcba"


genDict : String -> String -> Dict Char Char
genDict s1 s2 =
    List.map2 Tuple.pair (String.toList s1) (String.toList s2)
        |> Dict.fromList


chunk : String -> List String
chunk s =
    if String.length s <= 5 then
        [ s ]

    else
        String.left 5 s :: chunk (String.dropLeft 5 s)


encode : String -> String
encode =
    let
        dict =
            genDict plain cipher
    in
    String.filter Char.isAlphaNum
        >> String.toLower
        >> String.map (\c -> Dict.get c dict |> Maybe.withDefault c)
        >> chunk
        >> String.join " "


decode : String -> String
decode =
    let
        dict =
            genDict cipher plain
    in
    String.replace " " ""
        >> String.toLower
        >> String.map (\c -> Dict.get c dict |> Maybe.withDefault c)
