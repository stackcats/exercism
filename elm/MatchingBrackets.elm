module MatchingBrackets exposing (isPaired)


isPaired : String -> Bool
isPaired =
    let
        aux : List Char -> List Char -> Bool
        aux st lst =
            case lst of
                [] ->
                    st == []

                x :: xs ->
                    case x of
                        '[' ->
                            aux (x :: st) xs

                        '{' ->
                            aux (x :: st) xs

                        '(' ->
                            aux (x :: st) xs

                        ')' ->
                            case st of
                                '(' :: ys ->
                                    aux ys xs

                                _ ->
                                    False

                        '}' ->
                            case st of
                                '{' :: ys ->
                                    aux ys xs

                                _ ->
                                    False

                        ']' ->
                            case st of
                                '[' :: ys ->
                                    aux ys xs

                                _ ->
                                    False

                        _ ->
                            aux st xs
    in
    String.toList >> aux []
