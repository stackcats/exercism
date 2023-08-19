module RnaTranscription exposing (toRNA)


to : Char -> Result String String
to dna =
    case dna of
        'G' ->
            Ok "C"

        'C' ->
            Ok "G"

        'T' ->
            Ok "A"

        'A' ->
            Ok "U"

        _ ->
            Err "INVALID"


toRNA : String -> Result String String
toRNA =
    String.toList
        >> List.foldr (\c -> Result.map2 (++) (to c)) (Ok "")
