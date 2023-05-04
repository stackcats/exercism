square(SquareNumber, Value) :-
    SquareNumber > 0,
    SquareNumber < 65,
    Value is 2 ** (SquareNumber - 1).

sum(0, 0).
sum(N, X) :-
    Prev is N - 1,
    square(N, V),
    sum(Prev, PrevX),
    X is V + PrevX.

total(Value) :- sum(64, Value).
