nucleotide('A').
nucleotide('C').
nucleotide('G').
nucleotide('T').

count_list(Xs, Letter, Count) :-
    include(==(Letter), Xs, R),
    length(R, C),
    Count = (Letter, C).

nucleotide_count(Str, Count) :-
    string_chars(Str, Xs),
    maplist(nucleotide, Xs),
    maplist(count_list(Xs), ['A', 'C', 'G', 'T'], Count).
