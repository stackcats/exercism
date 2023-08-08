module GottaSnatchEmAll exposing (..)

import Set exposing (Set)


type alias Card =
    String


newCollection : Card -> Set Card
newCollection =
    Set.singleton


addCard : Card -> Set Card -> ( Bool, Set Card )
addCard card collection =
    ( Set.member card collection, Set.insert card collection )


tradeCard : Card -> Card -> Set Card -> ( Bool, Set Card )
tradeCard yourCard theirCard collection =
    let
        traded =
            collection |> Set.remove yourCard |> Set.insert theirCard
    in
    case ( Set.member yourCard collection, Set.member theirCard collection ) of
        ( _, True ) ->
            ( False, traded )

        ( False, _ ) ->
            ( False, traded )

        _ ->
            ( True, traded )


removeDuplicates : List Card -> List Card
removeDuplicates =
    Set.fromList >> Set.toList


extraCards : Set Card -> Set Card -> Int
extraCards s1 =
    Set.diff s1 >> Set.size


boringCards : List (Set Card) -> List Card
boringCards cards =
    case cards of
        [] ->
            []

        c :: cs ->
            List.foldl Set.intersect c cs |> Set.toList


totalCards : List (Set Card) -> Int
totalCards =
    List.foldl Set.union Set.empty >> Set.size


splitShinyCards : Set Card -> ( List Card, List Card )
splitShinyCards =
    Set.toList >> List.partition (String.startsWith "Shiny")
