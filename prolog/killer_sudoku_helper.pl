combination([], []).
combination([X|Xs], [X|Ys]) :-
    combination(Xs, Ys).
combination([_|Xs], Ys) :-
    combination(Xs, Ys).

aux(Size, Sum, Exclude, L) :-
    length(L, Size),
    sum_list(L, Sum),
    intersection(L, Exclude, S),
    S = [].

combinations(Size, Sum, Exclude, Combinations) :-
    numlist(1, 9, Xs),
    findall(Ys, combination(Xs, Ys), Ls),
    include(aux(Size, Sum, Exclude), Ls, Combinations).
