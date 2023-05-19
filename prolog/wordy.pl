wordy(Question, Answer) :-
    split_string(Question, " ?", "?", Words),
    parse_question(Words, Answer), 
    !.


minus(A, B, X) :- X is A - B.
multiplied(A, B, X) :- X is A * B.
divided(A, B, X) :- X is A / B.


parse_question(["What", "is"|Expr], Answer) :-
    parse_expr(Expr, Answer).
parse_question(_, _) :-
    throw(error(unknown_operation_error, _)).


parse_expr([H], Answer) :- number_string(Answer, H).
parse_expr([A, Op|_], _) :- 
    number_string(_, A),
    \+ number_string(_, Op),
    \+ member(Op, ["plus", "minus", "multiplied", "divided"]),
    throw(error(unknown_operation_error, _)).
parse_expr([A, "plus", B|Rest], Answer) :-
    do(A, B, plus, Rest, Answer).
parse_expr([A, "minus", B|Rest], Answer) :-
    do(A, B, minus, Rest, Answer).
parse_expr([A, "multiplied", "by", B|Rest], Answer) :-
    do(A, B, multiplied, Rest, Answer).
parse_expr([A, "divided", "by", B|Rest], Answer) :-
    do(A, B, divided, Rest, Answer).
parse_expr(_, _) :- throw(error(syntax_error, _)).


do(A, B, Op, Expr, Answer) :-
    number_string(N, A),
    number_string(M, B),
    call(Op, N, M, L),
    number_string(L, S),
    parse_expr([S|Expr], Answer).
