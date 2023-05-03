square_of_sum(N, Result) :-
    Sum is N * (N+1) / 2,
    Result is Sum * Sum.

sum_of_squares(1, 1).

sum_of_squares(N, Result) :-
    Prev is N - 1,
    sum_of_squares(Prev, X),
    Result is N * N + X.

difference(N, Result) :-
    square_of_sum(N, X),
    sum_of_squares(N, Y),
    Result is X - Y.
