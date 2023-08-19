module NucleotideCount exposing (nucleotideCounts)


type alias NucleotideCounts =
    { a : Int
    , t : Int
    , c : Int
    , g : Int
    }


nucleotideCounts : String -> Result String NucleotideCounts
nucleotideCounts =
    String.foldl (\c -> Result.andThen (update c)) (Ok { a = 0, t = 0, c = 0, g = 0 })


update : Char -> NucleotideCounts -> Result String NucleotideCounts
update nucleotide ({ a, t, c, g } as ct) =
    case nucleotide of
        'A' ->
            Ok { ct | a = a + 1 }

        'C' ->
            Ok { ct | c = c + 1 }

        'G' ->
            Ok { ct | g = g + 1 }

        'T' ->
            Ok { ct | t = t + 1 }

        _ ->
            Err "Invalid nucleotide in strand"
