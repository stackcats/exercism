module RobotSimulator exposing
    ( Bearing(..)
    , Robot
    , advance
    , defaultRobot
    , simulate
    , turnLeft
    , turnRight
    )


type Bearing
    = North
    | East
    | South
    | West


type alias Robot =
    { bearing : Bearing
    , coordinates : { x : Int, y : Int }
    }


defaultRobot : Robot
defaultRobot =
    { bearing = North
    , coordinates = { x = 0, y = 0 }
    }


toRight : Bearing -> Bearing
toRight bearing =
    case bearing of
        North ->
            East

        East ->
            South

        South ->
            West

        West ->
            North


toLeft : Bearing -> Bearing
toLeft bearing =
    case bearing of
        North ->
            West

        West ->
            South

        South ->
            East

        East ->
            North


turnRight : Robot -> Robot
turnRight robot =
    { robot | bearing = toRight robot.bearing }


turnLeft : Robot -> Robot
turnLeft robot =
    { robot | bearing = toLeft robot.bearing }


advance : Robot -> Robot
advance { bearing, coordinates } =
    let
        ( dx, dy ) =
            case bearing of
                North ->
                    ( 0, 1 )

                East ->
                    ( 1, 0 )

                South ->
                    ( 0, -1 )

                West ->
                    ( -1, 0 )
    in
    { bearing = bearing, coordinates = { x = coordinates.x + dx, y = coordinates.y + dy } }


go : Char -> Robot -> Robot
go direction =
    case direction of
        'L' ->
            turnLeft

        'R' ->
            turnRight

        _ ->
            advance


simulate : String -> Robot -> Robot
simulate directions robot =
    String.foldl go robot directions
