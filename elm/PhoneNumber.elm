module PhoneNumber exposing (getNumber)


isValidN : String -> Bool
isValidN n =
    List.any (\c -> String.startsWith c n) [ "0", "1" ]


getNumber : String -> Maybe String
getNumber phoneNumber =
    let
        cleanNumber =
            String.filter Char.isDigit phoneNumber

        number =
            if String.startsWith "1" cleanNumber then
                String.dropLeft 1 cleanNumber

            else
                cleanNumber
    in
    if String.length number /= 10 then
        Nothing

    else if isValidN number then
        Nothing

    else if isValidN (String.dropLeft 3 number) then
        Nothing

    else
        Just number
