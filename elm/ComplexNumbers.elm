module ComplexNumbers exposing
    ( Complex
    , abs
    , add
    , conjugate
    , div
    , exp
    , fromPair
    , fromReal
    , imaginary
    , mul
    , real
    , sub
    )


type alias Complex =
    ( Float, Float )


fromPair : ( Float, Float ) -> Complex
fromPair pair =
    pair


fromReal : Float -> Complex
fromReal a =
    ( a, 0 )


real : Complex -> Float
real ( a, _ ) =
    a


imaginary : Complex -> Float
imaginary ( _, b ) =
    b


conjugate : Complex -> Complex
conjugate ( a, b ) =
    ( a, -b )


abs : Complex -> Float
abs ( a, b ) =
    sqrt (a * a + b * b)


add : Complex -> Complex -> Complex
add ( a, b ) ( c, d ) =
    ( a + c, b + d )


sub : Complex -> Complex -> Complex
sub ( a, b ) ( c, d ) =
    ( a - c, b - d )


mul : Complex -> Complex -> Complex
mul ( a, b ) ( c, d ) =
    ( a * c - b * d, b * c + a * d )


div : Complex -> Complex -> Complex
div ( a, b ) ( c, d ) =
    let
        t =
            c * c + d * d
    in
    ( (a * c + b * d) / t, (b * c - a * d) / t )


e : Float
e =
    2.71828


exp : Complex -> Complex
exp ( a, b ) =
    ( e ^ a * cos b, e ^ a * sin b )
