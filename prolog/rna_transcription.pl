rna_to_dna('G', 'C').
rna_to_dna('C', 'G').
rna_to_dna('T', 'A').
rna_to_dna('A', 'U').

rna_transcription(Rna, Dna) :-
   string_chars(Rna, Xs),
   maplist(rna_to_dna, Xs, Ys),
   string_chars(Dna, Ys).

