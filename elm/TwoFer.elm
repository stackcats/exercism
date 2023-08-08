module TwoFer exposing (twoFer)


twoFer : Maybe String -> String
twoFer =
    Maybe.withDefault "you" >> say


say : String -> String
say name =
    "One for " ++ name ++ ", one for me."
