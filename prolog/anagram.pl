is_anagram(Word1, Word2) :-
    string_lower(Word1, L1),
    string_lower(Word2, L2),
    L1 \= L2,
    string_chars(L1, W1),
    string_chars(L2, W2),
    msort(W1, S1),
    msort(W2, S2),
    S1 = S2.

anagram(Word, Candidates, Anagrams) :-
    include([X]>>is_anagram(Word, X), Candidates, Anagrams).
