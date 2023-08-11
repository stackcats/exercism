module SumOfMultiples exposing (sumOfMultiples)


sumOfMultiples : List Int -> Int -> Int
sumOfMultiples divisors =
    (+) -1
        >> List.range 1
        >> List.filter (\n -> List.any (\d -> remainderBy d n == 0) divisors)
        >> List.sum
