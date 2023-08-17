module Etl exposing (transform)

import Dict exposing (Dict)


transform : Dict Int (List String) -> Dict String Int
transform =
    Dict.foldl (\k v acc -> List.foldl (\s dt -> Dict.insert (String.toLower s) k dt) acc v) Dict.empty
