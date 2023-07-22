encode(Plaintext, Ciphertext) :-
    string_chars(Plaintext, Plainchars),
    encode(Plainchars, '', 1, "", Ciphertext).

encode([], Prev, Ct, Acc, Ciphertext) :-
    Ct = 1,
    string_concat(Acc, Prev, Ciphertext).

encode([], Prev, Ct, Acc, Ciphertext) :-
    number_string(Ct, CStr),
    string_concat(CStr, Prev, Tmp),
    string_concat(Acc, Tmp, Ciphertext).

encode([C|Rest], Prev, Ct, Acc, Ciphertext) :-
    C = Prev,
    NewCt is Ct + 1,
    encode(Rest, Prev, NewCt, Acc, Ciphertext).

encode([C|Rest], Prev, Ct, Acc, Ciphertext) :-
    Ct = 1,
    string_concat(Acc, Prev, NewAcc),
    encode(Rest, C, 1, NewAcc, Ciphertext).

encode([C|Rest], Prev, Ct, Acc, Ciphertext) :-
    number_string(Ct, CStr),
    string_concat(CStr, Prev, Tmp),
    string_concat(Acc, Tmp, NewAcc),
    encode(Rest, C, 1, NewAcc, Ciphertext).

decode(Ciphertext, Plaintext) :-
    string_chars(Ciphertext, Cipherchars),
    decode(Cipherchars, 0, "", Plaintext).

decode([], _, Acc, Acc) :- !.

decode([C|Rest], Ct, Acc, Plaintext) :-
    char_type(C, digit),
    atom_number(C, D),
    NewCt is Ct * 10 + D,
    decode(Rest, NewCt, Acc, Plaintext).


decode([C|Rest], Ct, Acc, Plaintext) :-
    Ct = 0,
    string_concat(Acc, C, NewAcc),
    decode(Rest, 0, NewAcc, Plaintext).


decode([C|Rest], Ct, Acc, Plaintext) :-
    multiply_char(C, Ct, Cs),
    string_concat(Acc, Cs, NewAcc),
    decode(Rest, 0, NewAcc, Plaintext).

multiply_char(_, 0, '') :- !.
multiply_char(Char, N, Result) :-
    N > 0,
    N1 is N - 1,
    multiply_char(Char, N1, SubResult),
    string_concat(Char, SubResult, Result).
