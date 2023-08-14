module Isogram exposing (isIsogram)

import Dict exposing (..)


insert : Char -> Dict Char Int -> Dict Char Int
insert c dict =
    Dict.update c (Maybe.withDefault 0 >> (+) 1 >> Just) dict


isIsogram : String -> Bool
isIsogram =
    String.toLower
        >> String.filter Char.isAlpha
        >> String.foldl insert Dict.empty
        >> Dict.values
        >> List.all ((==) 1)
