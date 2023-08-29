module Bowling exposing (Rolls, score)


type alias Rolls =
    List Int


toFrames : Rolls -> Maybe Rolls
toFrames rolls =
    case rolls of
        [] ->
            Just []

        -- last frame with bonus
        10 :: a :: b :: [] ->
            if a > 10 || b > 10 then
                Nothing

            else if a /= 10 && a + b > 10 then
                Nothing

            else
                Just [ 10 + a + b ]

        -- strike
        10 :: a :: b :: fs ->
            Maybe.map (\s -> (10 + a + b) :: s) (toFrames (a :: b :: fs))

        a :: b :: fs ->
            if a + b > 10 then
                Nothing

            else if a + b == 10 then
                -- spare
                case fs of
                    -- wrong rolls, should with a fill ball
                    [] ->
                        Nothing

                    -- c is the fill ball
                    c :: [] ->
                        Just [ 10 + c ]

                    c :: _ ->
                        Maybe.map (\s -> (a + b + c) :: s) (toFrames fs)

            else
                -- open frame
                Maybe.map (\s -> (a + b) :: s) (toFrames fs)

        _ ->
            Nothing


score : Rolls -> Maybe Int
score =
    toFrames
        >> Maybe.andThen
            (\frames ->
                if List.length frames == 10 then
                    Just <| List.sum frames

                else
                    Nothing
            )
