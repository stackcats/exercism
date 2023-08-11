module SpaceAge exposing (Planet(..), ageOn)


type Planet
    = Mercury
    | Venus
    | Earth
    | Mars
    | Jupiter
    | Saturn
    | Uranus
    | Neptune


ageOn : Planet -> Float -> Float
ageOn planet seconds =
    let
        earth_years =
            seconds / 31557600
    in
    case planet of
        Mercury ->
            earth_years / 0.2408467

        Venus ->
            earth_years / 0.61519726

        Mars ->
            earth_years / 1.8808158

        Jupiter ->
            earth_years / 11.862615

        Saturn ->
            earth_years / 29.447498

        Uranus ->
            earth_years / 84.016846

        Neptune ->
            earth_years / 164.79132

        _ ->
            earth_years
