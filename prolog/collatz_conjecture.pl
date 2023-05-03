next(N, X) :-
    mod(N, 2) =:= 0,
    X is N // 2.

next(N, X) :-
    mod(N, 2) =\= 0,
    X is N * 3 + 1.

collatz_steps(1, 0).

collatz_steps(N, Steps) :-
    N > 1,
    \+ N = 1,
    next(N, M),
    collatz_steps(M, S),
    Steps is 1 + S.    

