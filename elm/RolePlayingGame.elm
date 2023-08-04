module RolePlayingGame exposing (Player, castSpell, introduce, revive)


type alias Player =
    { name : Maybe String
    , level : Int
    , health : Int
    , mana : Maybe Int
    }


introduce : Player -> String
introduce { name } =
    Maybe.withDefault "Mighty Magician" name


revive : Player -> Maybe Player
revive player =
    if player.health > 0 then
        Nothing

    else
        Just
            { player
                | health = 100
                , mana = Maybe.map (always 100) player.mana
            }


castSpell : Int -> Player -> ( Player, Int )
castSpell manaCost player =
    case Maybe.map ((<=) manaCost) player.mana of
        Just True ->
            ( { player | mana = Maybe.map ((+) -manaCost) player.mana }, 2 * manaCost )

        Just False ->
            ( player, 0 )

        Nothing ->
            ( { player | health = player.health - manaCost |> max 0 }, 0 )
