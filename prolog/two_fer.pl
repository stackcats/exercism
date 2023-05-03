two_fer(Name, Dialogue) :-
    swritef(Dialogue, "One for %w, one for me.", [Name]).

two_fer(Dialogue) :-
    Dialogue = "One for you, one for me.".
