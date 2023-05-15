binary(Str, Dec) :-
    string_chars(Str, Xs),
    aux(Xs, 0, Dec).

aux([], Dec, Dec).

aux([H|T], Dec, Res) :-
    char_type(H, digit),
    number_chars(N, [H]),
    N < 2,
    Next is Dec * 2 + N,
    aux(T, Next, Res).
