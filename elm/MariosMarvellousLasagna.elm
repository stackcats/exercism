module MariosMarvellousLasagna exposing (remainingTimeInMinutes)


remainingTimeInMinutes : Int -> Int -> Int
remainingTimeInMinutes layers minutes =
    let
        expectedMinutesInOven =
            40

        preparationTimeInMinutes n =
            2 * n
    in
    preparationTimeInMinutes layers + expectedMinutesInOven - minutes
