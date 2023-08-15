module MagicianInTraining exposing (..)

import Array exposing (Array)


getCard : Int -> Array Int -> Maybe Int
getCard =
    Array.get


setCard : Int -> Int -> Array Int -> Array Int
setCard =
    Array.set


addCard : Int -> Array Int -> Array Int
addCard =
    Array.push


removeCard : Int -> Array Int -> Array Int
removeCard index deck =
    let
        left =
            Array.slice 0 index deck

        right =
            Array.slice (index + 1) (Array.length deck) deck
    in
    Array.append left right


evenCardCount : Array Int -> Int
evenCardCount =
    Array.filter (modBy 2 >> (==) 0) >> Array.length
