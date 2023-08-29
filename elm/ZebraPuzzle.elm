module ZebraPuzzle exposing (Nationality(..), drinksWater, ownsZebra)


type Nationality
    = Japanese
    | Norwegian


drinksWater : Maybe Nationality
drinksWater =
    Just Norwegian


ownsZebra : Maybe Nationality
ownsZebra =
    Just Japanese
