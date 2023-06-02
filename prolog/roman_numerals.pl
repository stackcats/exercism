convert(N, Numeral) :-
    Letters = [
	["I", "V", "X"],
	["X", "L", "C"],
	["C", "D", "M"],
	["M", "M", "M"]
    ],
    convert(N, Letters, "", Numeral).

convert(0, _, Numeral, Numeral).

convert(N, [[L, V, X]|Rest], Str, Numeral) :-
    N > 0,
    D is N mod 10,
    concat(D, L, V, X, Str, NStr),
    N1 is N div 10,
    convert(N1, Rest, NStr, Numeral).


concat(D, L, V, X, Str, NStr) :-
    (
	D = 0,
	NStr = Str;
	
	(D = 1; D = 2; D = 3),
	repeat(L, D, R),
	string_concat(R, Str, NStr);
	
	D = 4,
	string_concat(L, V, R),
	string_concat(R, Str, NStr);
	
	D = 5,
	string_concat(V, Str, NStr);
	
	(D = 6; D = 7; D = 8),
	D1 is D - 5,
	repeat(L, D1, R),
	string_concat(V, R, R1),
	string_concat(R1, Str, NStr);
	
	string_concat(L, X, R),
	string_concat(R, Str, NStr)
    ).


repeat(Str, 1, Str).

repeat(Str, Num, Res):-
    Num1 is Num-1,
    repeat(Str, Num1, Res1),
    string_concat(Str, Res1, Res).
