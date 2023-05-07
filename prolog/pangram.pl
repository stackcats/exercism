pangram(Sentence) :-
    string_lower(Sentence, Lower),
    string_chars(Lower, Xs),
    include([X]>>char_type(X, alpha), Xs, Ys),
    sort(Ys, Zs),
    length(Zs, L),
    L = 26.
