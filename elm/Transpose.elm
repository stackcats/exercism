module Transpose exposing (transpose)


trans : List (List Char) -> List (List Char)
trans lst =
    case lst of
        [] ->
            []

        [] :: xs ->
            trans xs

        _ ->
            let
                ( hs, ts ) =
                    List.foldl
                        (\l ( h, t ) ->
                            case l of
                                [] ->
                                    ( h, t )

                                x :: xs ->
                                    ( h ++ [ x ], t ++ [ xs ] )
                        )
                        ( [], [] )
                        lst
            in
            hs :: trans ts


transpose : List String -> List String
transpose lines =
    let
        max_len =
            List.foldl (\s acc -> max acc (String.length s)) 0 lines
    in
    List.map (String.padRight max_len ' ' >> String.toList) lines
        |> trans
        |> List.foldr
            (\s ( acc, pad ) ->
                let
                    t =
                        String.fromList s
                            |> String.trimRight
                            |> String.padRight pad ' '
                in
                ( t :: acc, max pad (String.length t) )
            )
            ( [], 0 )
        |> Tuple.first
