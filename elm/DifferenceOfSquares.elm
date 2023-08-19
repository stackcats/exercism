module DifferenceOfSquares exposing (difference, squareOfSum, sumOfSquares)


squareOfSum : Int -> Int
squareOfSum =
    List.range 1
        >> List.sum
        >> (\c -> c ^ 2)


sumOfSquares : Int -> Int
sumOfSquares =
    List.range 1
        >> List.map (\c -> c ^ 2)
        >> List.sum


difference : Int -> Int
difference n =
    squareOfSum n - sumOfSquares n
