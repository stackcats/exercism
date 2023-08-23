module TwoBucket exposing (BucketNumber(..), measure)

import Set exposing (Set)


type BucketNumber
    = One
    | Two


type alias State =
    { moves : Int, bucketOne : Int, bucketTwo : Int }


measure : Int -> Int -> Int -> BucketNumber -> Maybe State
measure bucketOneSize bucketTwoSize goal startBucket =
    let
        loop : Set ( Int, Int ) -> List ( Int, Int, Int ) -> Maybe State
        loop st lst =
            case lst of
                [] ->
                    Nothing

                ( b1, b2, ct ) :: rest ->
                    if Set.member ( b1, b2 ) st then
                        loop st rest

                    else if startBucket == One && b1 == 0 && b2 == bucketTwoSize then
                        loop st rest

                    else if startBucket == Two && b1 == bucketOneSize && b2 == 0 then
                        loop st rest

                    else if b1 == goal then
                        Just { moves = ct, bucketOne = b1, bucketTwo = b2 }

                    else if b2 == goal then
                        Just { moves = ct, bucketOne = b1, bucketTwo = b2 }

                    else
                        let
                            diff1 =
                                min (bucketTwoSize - b2) b1

                            diff2 =
                                min (bucketOneSize - b1) b2
                        in
                        List.append rest
                            [ ( b1 - diff1, b2 + diff1, ct + 1 )
                            , ( 0, b2, ct + 1 )
                            , ( bucketOneSize, b2, ct + 1 )
                            , ( b1 + diff2, b2 - diff2, ct + 1 )
                            , ( b1, 0, ct + 1 )
                            , ( b1, bucketTwoSize, ct + 1 )
                            ]
                            |> loop (Set.insert ( b1, b2 ) st)
    in
    loop Set.empty [ ( 0, 0, 0 ) ]
