module TopScorers exposing (..)

import Dict exposing (Dict)
import TopScorersSupport exposing (PlayerName)


updateGoalCountForPlayer : PlayerName -> Dict PlayerName Int -> Dict PlayerName Int
updateGoalCountForPlayer playerName =
    Dict.update playerName (Maybe.map ((+) 1) >> Maybe.withDefault 1 >> Just)


aggregateScorers : List PlayerName -> Dict PlayerName Int
aggregateScorers =
    List.foldl updateGoalCountForPlayer Dict.empty


removeInsignificantPlayers : Int -> Dict PlayerName Int -> Dict PlayerName Int
removeInsignificantPlayers goalThreshold =
    Dict.filter (\_ ct -> ct >= goalThreshold)


resetPlayerGoalCount : PlayerName -> Dict PlayerName Int -> Dict PlayerName Int
resetPlayerGoalCount playerName =
    Dict.insert playerName 0


format : ( PlayerName, Int ) -> String
format ( playerName, goalCount ) =
    playerName ++ ": " ++ String.fromInt goalCount


formatPlayer : PlayerName -> Dict PlayerName Int -> String
formatPlayer playerName playerGoalCounts =
    format ( playerName, Dict.get playerName playerGoalCounts |> Maybe.withDefault 0 )


formatPlayers : Dict PlayerName Int -> String
formatPlayers =
    Dict.toList >> List.sortBy Tuple.first >> List.map format >> String.join ", "


combineGames : Dict PlayerName Int -> Dict PlayerName Int -> Dict PlayerName Int
combineGames game1 game2 =
    Dict.merge
        Dict.insert
        (\name count1 count2 -> Dict.insert name (count1 + count2))
        Dict.insert
        game1
        game2
        Dict.empty
