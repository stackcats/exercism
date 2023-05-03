len(0, 0).
len(N, X) :-
    N > 0,
    Next is N // 10,
    len(Next, Y),
    X is Y + 1.

digits_power_sum(0, _, 0).
digits_power_sum(N, Len, X) :-
    N > 0,
    Next is N // 10,
    digits_power_sum(Next, Len, Y),
    X is mod(N, 10) ** Len + Y.

armstrong_number(N) :-
    len(N, Len),
    digits_power_sum(N, Len, Sum),
    N = Sum.
