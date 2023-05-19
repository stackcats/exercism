:- use_module(library(pcre)).

aux("", Acc, Acc).
aux(Word, Acc, Res) :-
    string_chars(Word, [H|_]),
    string_concat(Acc, H, Res).
    
abbreviate(Sentence, Acromym) :-
    string_upper(Sentence, UpperSentence),
    re_replace("[^A-Z ']"/g, " ", UpperSentence, Strs),
    split_string(Strs, " ", "", Words),
    foldl(aux, Words, "", Acromym).
