can_chain([]).
can_chain([(X, X)]).
can_chain([H|T]) :-
    select(X, T, Rest),
    eliminate(H, X, New),
    can_chain([New|Rest]).

eliminate((L1, X), (X, R1), (L1, R1)).
eliminate((L1, X), (L2, X), (L1, L2)).
