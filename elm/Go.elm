module Go exposing (..)

import GoSupport exposing (..)
import Result exposing (andThen)


applyRules : Game -> Rule -> NonValidatingRule -> Rule -> Rule -> Game
applyRules game oneStonePerPointRule captureRule libertyRule koRule =
    let
        r =
            game
                |> koRule
                |> andThen libertyRule
                |> andThen oneStonePerPointRule
    in
    case r of
        Err error ->
            { game | error = error }

        Ok game2 ->
            game2 |> captureRule |> changePlayer
