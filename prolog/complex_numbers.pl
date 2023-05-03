real((A, _), R) :- R is A.

imaginary((_, B), R) :- R is B.

conjugate((A, B), (X, Y)) :- 
    X is A,
    Y is -B.

abs((A, B), R) :- R is sqrt(A ** 2 + B ** 2).

add((A, B), (C, D), (X, Y)) :-
    X is A + C,
    Y is B + D.

sub((A, B), (C, D), (X, Y)) :-
    X is A - C,
    Y is B - D.

mul((A, B), (C, D), (X, Y)) :-
    X is A * C - B * D,
    Y is B * C + A * D.

div((A, B), (C, D), (X, Y)) :-
    Z is C ** 2 + D ** 2,
    X is (A * C + B * D) / Z,
    Y is (B * C - A * D) / Z.
