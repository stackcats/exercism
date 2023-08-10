module TreasureFactory exposing (TreasureChest, getTreasure, makeChest, makeTreasureChest, secureChest, uniqueTreasures)


type TreasureChest treasure
    = TreasureChest String treasure


getTreasure : String -> TreasureChest a -> Maybe a
getTreasure passwordAttempt (TreasureChest password treasure) =
    if passwordAttempt == password then
        Just treasure

    else
        Nothing


type Chest treasure conditions
    = Chest String treasure


makeChest : String -> treasure -> Chest treasure {}
makeChest password treasure =
    Chest password treasure


secureChest : Chest treasure conditions -> Maybe (Chest treasure { conditions | securePassword : () })
secureChest (Chest password treasure) =
    if String.length password >= 8 then
        Just (Chest password treasure)

    else
        Nothing


uniqueTreasures : List (Chest treasure conditions) -> List (Chest treasure { conditions | uniqueTreasure : () })
uniqueTreasures chests =
    let
        treasures =
            List.map (\(Chest _ teasure) -> teasure) chests

        unique : Chest treasure conditions -> Maybe (Chest treasure { conditions | uniqueTreasure : () })
        unique (Chest password treasure) =
            if treasures |> List.filter (\t -> t == treasure) |> List.length |> (==) 1 then
                Just (Chest password treasure)

            else
                Nothing
    in
    List.filterMap unique chests


makeTreasureChest : Chest treasure { conditions | securePassword : (), uniqueTreasure : () } -> TreasureChest treasure
makeTreasureChest (Chest password treasure) =
    TreasureChest password treasure
