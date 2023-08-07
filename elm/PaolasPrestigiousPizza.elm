module PaolasPrestigiousPizza exposing
    ( Pizza
    , ingredientsParser
    , menuParser
    , oneIngredientParser
    , pizzaParser
    , priceParser
    , vegetarianParser
    , wordParser
    )

import Parser exposing ((|.), (|=), Parser)


type alias Pizza =
    { name : String
    , vegetarian : Bool
    , ingredients : List String
    , price : Int
    }


priceParser : Parser Int
priceParser =
    Parser.succeed identity
        |= Parser.int
        |. Parser.symbol "€"


vegetarianParser : Parser Bool
vegetarianParser =
    Parser.oneOf
        [ Parser.succeed True
            |. Parser.symbol "(v)"
        , Parser.succeed False
        ]


wordParser : Parser String
wordParser =
    Parser.chompWhile Char.isAlpha
        |> Parser.getChompedString
        |> Parser.map String.toLower


ingredientsParser : Parser (List String)
ingredientsParser =
    Parser.sequence
        { start = ""
        , separator = ","
        , end = ""
        , spaces = Parser.spaces
        , item = oneIngredientParser
        , trailing = Parser.Forbidden
        }


pizzaParser : Parser Pizza
pizzaParser =
    Parser.succeed Pizza
        |= wordParser
        |. Parser.spaces
        |= vegetarianParser
        |. Parser.symbol ":"
        |. Parser.spaces
        |= ingredientsParser
        |. Parser.spaces
        |. Parser.symbol "-"
        |. Parser.spaces
        |= priceParser


menuParser : Parser (List Pizza)
menuParser =
    Parser.sequence
        { start = ""
        , separator = "\n"
        , end = ""
        , spaces = Parser.chompWhile ((==) ' ')
        , item = pizzaParser
        , trailing = Parser.Optional
        }
        |. Parser.end


oneIngredientParser : Parser String
oneIngredientParser =
    Parser.chompWhile (\c -> Char.isAlpha c || c == ' ')
        |> Parser.getChompedString
        |> Parser.map (String.trim >> String.toLower)
        |> Parser.andThen
            (\s ->
                if String.isEmpty s then
                    Parser.problem "empty string"

                else
                    Parser.succeed s
            )
