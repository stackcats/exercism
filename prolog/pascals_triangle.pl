pascal(0, []).
pascal(N, Rows) :-
    numlist(2, N, Xs),
    foldl([_, Acc, Next] >> ([H|_] = Acc, next(H, Ys), Next = [Ys|Acc]), Xs, [[1]], Ys),
    reverse(Ys, Rows).
    
next([], [1]).
next([H|T], Res) :-
    next(T, H, [H], Res).
next([], _, Pre, [1|Pre]).
next([H|T], P, Pre, Res) :-
    X is P + H,
    next(T, H, [X | Pre], Res).
