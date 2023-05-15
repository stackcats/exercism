sum_of_multiples(Factors, Limit, Sum) :-
    High is Limit - 1,
    findall(X, (member(F, Factors), between(F, High, X), X mod F =:= 0), Xs),
    sort(Xs, Ys),
    sum_list(Ys, Sum).
