module WordCount exposing (wordCount)

import Dict exposing (Dict)


split : Char -> List Char -> List (List Char) -> List Char -> List (List Char)
split prev word words cs =
    case cs of
        [] ->
            word :: words

        [ c ] ->
            if Char.isAlphaNum c then
                split c (word ++ [ c ]) words []

            else
                split c word words []

        x :: y :: rest ->
            if x == '\'' then
                if Char.isAlpha prev && Char.isAlpha y then
                    split y (word ++ [ x, y ]) words rest

                else
                    split x [] (word :: words) (y :: rest)

            else if Char.isAlphaNum x then
                split x (word ++ [ x ]) words (y :: rest)

            else
                split x [] (word :: words) (y :: rest)


wordCount : String -> Dict String Int
wordCount =
    String.toLower
        >> String.toList
        >> split ' ' [] []
        >> List.map String.fromList
        >> List.filter (String.isEmpty >> not)
        >> List.foldl (\s acc -> Dict.update s (Maybe.withDefault 0 >> (+) 1 >> Just) acc) Dict.empty
