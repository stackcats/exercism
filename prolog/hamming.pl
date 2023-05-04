hamming_distance(Str1, Str2, Dist) :-
    string_chars(Str1, Xs),
    string_chars(Str2, Ys),
    foldl([X, Y, Acc, R] >> (X = Y -> R is Acc ; R is Acc + 1), Xs, Ys, 0, Dist).
