module CustomSet exposing (diff, disjoint, empty, equal, fromList, insert, intersect, isEmpty, member, subset, toList, union)

import Dict exposing (Dict)


type alias Set =
    Dict Int Int


empty : Set
empty =
    Dict.empty


insert : Int -> Set -> Set
insert element =
    Dict.insert element 0


toList : Set -> List Int
toList =
    Dict.keys


fromList : List Int -> Set
fromList =
    List.map (\elem -> ( elem, 0 ))
        >> Dict.fromList


isEmpty : Set -> Bool
isEmpty =
    Dict.isEmpty


member : Int -> Set -> Bool
member =
    Dict.member


equal : Set -> Set -> Bool
equal =
    (==)


union : Set -> Set -> Set
union =
    Dict.union


intersect : Set -> Set -> Set
intersect =
    Dict.intersect


diff : Set -> Set -> Set
diff =
    Dict.diff


subset : Set -> Set -> Bool
subset set =
    Dict.intersect set >> equal set


disjoint : Set -> Set -> Bool
disjoint set =
    Dict.intersect set >> isEmpty
