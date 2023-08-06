module BlorkemonCards exposing
    ( Card
    , compareShinyPower
    , expectedWinner
    , isMorePowerful
    , maxPower
    , sortByCoolness
    , sortByMonsterName
    )


type alias Card =
    { monster : String, power : Int, shiny : Bool }


isMorePowerful : Card -> Card -> Bool
isMorePowerful card1 card2 =
    card1.power > card2.power


maxPower : Card -> Card -> Int
maxPower card1 card2 =
    max card1.power card2.power


sortByMonsterName : List Card -> List Card
sortByMonsterName =
    List.sortBy .monster


compareCoolness : Card -> Card -> Order
compareCoolness card1 card2 =
    case ( card1.shiny, card2.shiny ) of
        ( True, False ) ->
            LT

        ( False, True ) ->
            GT

        _ ->
            compare card2.power card1.power


sortByCoolness : List Card -> List Card
sortByCoolness =
    List.sortWith compareCoolness


compareShinyPower : Card -> Card -> Order
compareShinyPower card1 card2 =
    if card1.power == card2.power then
        case ( card1.shiny, card2.shiny ) of
            ( True, False ) ->
                GT

            ( False, True ) ->
                LT

            _ ->
                EQ

    else if card1.power < card2.power then
        LT

    else
        GT


expectedWinner : Card -> Card -> String
expectedWinner card1 card2 =
    case compareShinyPower card1 card2 of
        EQ ->
            "too close to call"

        LT ->
            card2.monster

        GT ->
            card1.monster
