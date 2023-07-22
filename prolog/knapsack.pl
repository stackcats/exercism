maximum_value([], _, 0).

maximum_value(Items, Capacity, Value) :-
    maximum_value(Items, Capacity, 0, Value).

maximum_value([], _, Value, Value) :- Value > 0.

maximum_value([item(Weight, Value) | Rest], Capacity, Acc, MaxValue) :-
    Weight =< Capacity,
    RemainingCapacity is Capacity - Weight,
    Acc1 is Acc + Value,
    maximum_value(Rest, RemainingCapacity, Acc1, MaxValue).

maximum_value([item(Weight, _) | Rest], Capacity, Acc, MaxValue) :-
    maximum_value(Rest, Capacity, Acc, MaxValue).
