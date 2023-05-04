isogram(Str) :-
    string_lower(Str, Lower),
    string_chars(Lower, Xs),
    include([X]>>char_type(X, alpha), Xs, Ys),
    is_set(Ys).
