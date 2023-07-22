fewest_coins(Coins, Target, Change) :-
    reverse(Coins, CoinsRev),
    coins(CoinsRev, Target, Change).

coins(_, 0, []).

coins([Coin | Coins], Target, Change) :-
    Target >= Coin, NewTarget is Target - Coin,
    coins([Coin | Coins], NewTarget, NewChange),
    append(NewChange, [Coin], Change).

coins([_ | Coins], Target, Change) :-
    coins(Coins, Target, Change).
