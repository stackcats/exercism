string_reverse(S, Reversed) :-
    string_chars(S, X),
    reverse(X, Y),
    string_chars(Reversed, Y).
