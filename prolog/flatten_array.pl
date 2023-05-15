flatten_list([], []).
flatten_list([H|T], Flattened) :-
    H = nil,
    flatten_list(T, Flattened).
flatten_list([H|T], Flattened) :-
    is_list(H),
    flatten_list(H, Hs),
    flatten_list(T, Ts),
    append(Hs, Ts, Flattened).
flatten_list([H|T], Flattened) :-
    flatten_list(T, Ts),
    Flattened = [H|Ts].
