use std::collections::HashMap;

pub fn can_construct_note(magazine: &[&str], note: &[&str]) -> bool {
    let mut note_mp = HashMap::new();

    for n in note {
        *note_mp.entry(n).or_insert(0) += 1;
    }

    let mut maga_mp = HashMap::new();

    for maga in magazine {
        *maga_mp.entry(maga).or_insert(0) += 1;
    }

    for (k, v) in &note_mp {
        let ct = maga_mp.get(k).unwrap_or(&0);
        if ct < v {
            return false;
        }
    }

    true
}
