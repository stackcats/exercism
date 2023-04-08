def to_rna(dna_strand):
    dt = {'G': 'C', 'C': 'G', 'T': 'A', 'A': 'U'}
    return ''.join([dt[c] for c in dna_strand])
