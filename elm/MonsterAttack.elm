module MonsterAttack exposing (..)


type alias MonsterDamage =
    String


type alias Weapon =
    String


attackWith : Weapon -> MonsterDamage -> Int -> MonsterDamage
attackWith weapon monsterDamage strength =
    String.concat
        [ monsterDamage
        , "Attacked with "
        , weapon
        , " of strength "
        , String.fromInt strength
        , "."
        ]


attackWithSword1 : MonsterDamage -> Int -> MonsterDamage
attackWithSword1 =
    attackWith "sword"


attackWithClaw1 : MonsterDamage -> Int -> MonsterDamage
attackWithClaw1 =
    attackWith "claw"


attack1 : MonsterDamage -> MonsterDamage
attack1 monsterDamage =
    let
        r1 =
            attackWithSword1 monsterDamage 5

        r2 =
            attackWithClaw1 r1 1

        r3 =
            attackWithClaw1 r2 1

        r4 =
            attackWithSword1 r3 5
    in
    r4


attackWithSword2 : Int -> MonsterDamage -> MonsterDamage
attackWithSword2 strength monsterDamage =
    attackWith "sword" monsterDamage strength


attackWithClaw2 : Int -> MonsterDamage -> MonsterDamage
attackWithClaw2 strength monsterDamage =
    attackWith "claw" monsterDamage strength


attack2 : MonsterDamage -> MonsterDamage
attack2 monsterDamage =
    monsterDamage
        |> attackWithSword2 5
        |> attackWithClaw2 1
        |> attackWithClaw2 1
        |> attackWithSword2 5


attack3 : MonsterDamage -> MonsterDamage
attack3 =
    attackWithSword2 5
        >> attackWithClaw2 1
        >> attackWithClaw2 1
        >> attackWithSword2 5
