use std::collections::HashMap;

fn is_nucleotide(nucleotide: char) -> bool {
    match nucleotide {
        'A' | 'C' | 'G' | 'T' => true,
        _ => false,
    }
}
pub fn count(nucleotide: char, dna: &str) -> Result<usize, char> {
    if !is_nucleotide(nucleotide) {
        return Err(nucleotide);
    }

    let mut ct = 0;

    for d in dna.chars() {
        if !is_nucleotide(d) {
            return Err(d);
        }
        if d == nucleotide {
            ct += 1;
        }
    }

    Ok(ct)
}

pub fn nucleotide_counts(dna: &str) -> Result<HashMap<char, usize>, char> {
    let mut mp = HashMap::new();

    "ACGT".chars().for_each(|c| {
        mp.insert(c, 0);
    });

    for d in dna.chars() {
        if !is_nucleotide(d) {
            return Err(d);
        }
        mp.entry(d).and_modify(|ct| *ct += 1);
    }

    Ok(mp)
}
