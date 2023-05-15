aux(N, M, Sound, S) :-
    N mod M =:= 0 -> S = Sound; S = "".

convert(N, Sounds) :-
    aux(N, 3, "Pling", S1),
    aux(N, 5, "Plang", S2),
    aux(N, 7, "Plong", S3),
    foldl([S, Acc, R] >> string_concat(Acc, S, R), [S1, S2, S3], "", R),
    (R = "" -> number_string(N, Sounds) ; Sounds = R).
