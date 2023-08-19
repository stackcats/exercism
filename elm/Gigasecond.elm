module Gigasecond exposing (add)

import Time


add : Time.Posix -> Time.Posix
add =
    Time.posixToMillis
        >> (+) 1000000000000
        >> Time.millisToPosix
