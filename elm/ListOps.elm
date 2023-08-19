module ListOps exposing
    ( append
    , concat
    , filter
    , foldl
    , foldr
    , length
    , map
    , reverse
    )


length : List a -> Int
length list =
    let
        f : List a -> Int -> Int
        f lst len =
            case lst of
                [] ->
                    len

                _ :: xs ->
                    f xs (len + 1)
    in
    f list 0


reverse : List a -> List a
reverse list =
    let
        f : List a -> List a -> List a
        f lst rev =
            case lst of
                [] ->
                    rev

                x :: xs ->
                    f xs (x :: rev)
    in
    f list []


foldl : (a -> b -> b) -> b -> List a -> b
foldl f acc list =
    case list of
        [] ->
            acc

        x :: xs ->
            foldl f (f x acc) xs


foldr : (a -> b -> b) -> b -> List a -> b
foldr f acc list =
    case list of
        [] ->
            acc

        x :: xs ->
            f x (foldr f acc xs)


map : (a -> b) -> List a -> List b
map f list =
    case list of
        [] ->
            []

        x :: xs ->
            f x :: map f xs


filter : (a -> Bool) -> List a -> List a
filter f list =
    case list of
        [] ->
            []

        x :: xs ->
            if f x then
                x :: filter f xs

            else
                filter f xs


append : List a -> List a -> List a
append xs ys =
    case xs of
        [] ->
            ys

        [ x ] ->
            x :: ys

        x :: rest ->
            x :: append rest ys


concat : List (List a) -> List a
concat =
    foldr append []
