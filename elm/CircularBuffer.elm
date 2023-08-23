module CircularBuffer exposing (CircularBuffer, clear, new, overwrite, read, write)


type alias CircularBuffer a =
    { left : List a
    , right : List a
    , len : Int
    , cap : Int
    }


new : Int -> CircularBuffer a
new size =
    CircularBuffer [] [] 0 size


write : a -> CircularBuffer a -> Maybe (CircularBuffer a)
write element buffer =
    if buffer.len >= buffer.cap then
        Nothing

    else
        Just { buffer | left = element :: buffer.left, len = buffer.len + 1 }


overwrite : a -> CircularBuffer a -> CircularBuffer a
overwrite element buffer =
    if buffer.len >= buffer.cap then
        let
            right =
                List.reverse buffer.left
                    |> List.append buffer.right
                    |> List.tail
                    |> Maybe.withDefault []
        in
        { buffer | left = [ element ], right = right }

    else
        { buffer | left = element :: buffer.left, len = buffer.len + 1 }


read : CircularBuffer a -> Maybe ( a, CircularBuffer a )
read buffer =
    if buffer.len == 0 then
        Nothing

    else
        case buffer.right of
            [] ->
                read { buffer | right = List.reverse buffer.left, left = [] }

            x :: xs ->
                Just ( x, { buffer | right = xs, len = buffer.len - 1 } )


clear : CircularBuffer a -> CircularBuffer a
clear buffer =
    { buffer | left = [], right = [], len = 0 }
