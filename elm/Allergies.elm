module Allergies exposing (Allergy(..), isAllergicTo, toList)

import Bitwise


type Allergy
    = Eggs
    | Peanuts
    | Shellfish
    | Strawberries
    | Tomatoes
    | Chocolate
    | Pollen
    | Cats


allergicToScore : Allergy -> Int
allergicToScore allergy =
    case allergy of
        Eggs ->
            1

        Peanuts ->
            2

        Shellfish ->
            4

        Strawberries ->
            8

        Tomatoes ->
            16

        Chocolate ->
            32

        Pollen ->
            64

        Cats ->
            128


isAllergicTo : Allergy -> Int -> Bool
isAllergicTo allergy score =
    let
        a =
            allergicToScore allergy
    in
    Bitwise.and a score == a


toList : Int -> List Allergy
toList score =
    [ Eggs
    , Peanuts
    , Shellfish
    , Strawberries
    , Tomatoes
    , Chocolate
    , Pollen
    , Cats
    ]
        |> List.filter (\a -> isAllergicTo a score)
