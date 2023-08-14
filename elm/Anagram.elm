module Anagram exposing (detect)

import Set


transform : String -> String
transform =
    String.toList >> List.sort >> String.fromList


detect : String -> List String -> List String
detect word =
    let
        lw =
            String.toLower word

        sorted =
            transform lw
    in
    List.foldl
        (\s ( acc, set ) ->
            let
                l =
                    String.toLower s

                t =
                    transform l
            in
            if l /= lw && t == sorted && not (Set.member t set) then
                ( s :: acc, set )

            else
                ( acc, set )
        )
        ( [], Set.empty )
        >> Tuple.first
        >> List.reverse
