module Raindrops exposing (raindrops)


rule : Int -> ( Int, String ) -> String
rule n ( d, s ) =
    if remainderBy d n == 0 then
        s

    else
        ""


raindrops : Int -> String
raindrops number =
    let
        s =
            [ ( 3, "Pling" ), ( 5, "Plang" ), ( 7, "Plong" ) ]
                |> List.map (rule number)
                |> String.concat
    in
    if s == "" then
        String.fromInt number

    else
        s
