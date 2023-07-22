replace([_|T], 0, E, [E|T]) :- !.
replace([H|T], N, E, Xs)    :-
  succ(N1, N), replace(T, N1, E, Xs1), Xs = [H|Xs1]. 

replace_in([H|T], (0, Y), E, Xs) :- replace(H, Y, E, NH), Xs = [NH|T], !.
replace_in([H|T], (X, Y), E, Xs) :- 
  succ(X1, X), replace_in(T, (X1, Y), E, Xs1), Xs = [H|Xs1].

get_in(Xs, (X, Y), E) :- nth0(X, Xs, L), nth0(Y, L, E).

create(N, Mx) :- 
  numlist(1, N, Ns),
  findall(X, (member(_, Ns), X = nil), Ls),
  findall(X, (member(_, Ns), X = Ls), Mx).

ops(right, (X,Y), (A,B), (C,D), D1, D2) :- 
  A is X, B is Y+1, D1 = right, C is X+1, D is Y, D2 = down.

ops(left, (X,Y), (A,B), (C,D), D1, D2) :- 
  A is X, B is Y-1, D1 = left, C is X-1, D is Y, D2 = up.  

ops(up, (X,Y), (A,B), (C,D), D1, D2) :-
  A is X-1, B is Y, D1 = up, C is X, D is Y+1, D2 = right.

ops(down, (X,Y), (A,B), (C,D), D1, D2) :- 
  A is X+1, B is Y, D1 = down, C is X, D is Y-1, D2 = left. 


next(Dir, Mx, Coor, NCoor, NDir) :-
  ops(Dir, Coor, C1, C2, D1, D2), 
  (get_in(Mx, C1, nil) -> NCoor = C1, NDir = D1
                        ; NCoor = C2, NDir = D2).  

spiralH(Dir, Mx, Coor, [H|Vs], R)  :-
 replace_in(Mx, Coor, H, NMx),
 (Vs = [] -> R = NMx
           ; next(Dir, Mx, Coor, NCoor, NDir),
             spiralH(NDir, NMx, NCoor, Vs, R)).  

spiral(0, []).
spiral(N, Mx) :- 
  Sq is N*N, numlist(1, Sq, Ns), 
  create(N, EMx), spiralH(right, EMx, (0,0), Ns, Mx).
