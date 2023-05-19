:- use_module(library(clpfd)).


solve(Solution) :-
    Names = [amara, bjorn, cora, dale, emiko],
    Floors = [Amara, Bjorn, Cora, Dale, Emiko],
    Floors ins 1..5,
    all_distinct(Floors),
    Amara #< 5,
    Bjorn #> 1,
    Cora #> 1, Cora #< 5,
    Dale #> Bjorn,
    abs(Emiko - Cora) #> 1,
    abs(Cora - Bjorn) #> 1,
    pairs_keys_values(Solution, Names, Floors),
    label(Floors).


floor(Name, Floor) :-
    solve(Solution),
    member(Name-Floor, Solution).

