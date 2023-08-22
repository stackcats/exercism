module Wordy exposing (answer)

import Parser exposing (..)


type Expr
    = Plus Int
    | Minus Int
    | MultipleBy Int
    | DividedBy Int


plus : Parser Expr
plus =
    succeed Plus
        |. symbol " plus "
        |= myInt


minus : Parser Expr
minus =
    succeed Minus
        |. symbol " minus "
        |= myInt


multipleBy : Parser Expr
multipleBy =
    succeed MultipleBy
        |. symbol " multiplied by "
        |= myInt


dividedBy : Parser Expr
dividedBy =
    succeed DividedBy
        |. symbol " divided by "
        |= myInt


expressions : Parser (List Expr)
expressions =
    let
        aux : List Expr -> Parser (Step (List Expr) (List Expr))
        aux exprs =
            oneOf
                [ succeed (\e -> Loop (e :: exprs))
                    |= oneOf
                        [ plus
                        , minus
                        , multipleBy
                        , dividedBy
                        ]
                , succeed ()
                    |> map (\_ -> Done (List.reverse exprs))
                ]
    in
    loop [] aux


myInt : Parser Int
myInt =
    oneOf
        [ succeed negate
            |. symbol "-"
            |= int
        , int
        ]


eval : Expr -> Int -> Int
eval expr n =
    case expr of
        Plus m ->
            n + m

        Minus m ->
            n - m

        MultipleBy m ->
            n * m

        DividedBy m ->
            n // m


parse : Parser Int
parse =
    succeed (List.foldl eval)
        |. symbol "What is "
        |= myInt
        |= expressions
        |. symbol "?"
        |. end


answer : String -> Maybe Int
answer =
    run parse >> Result.toMaybe
