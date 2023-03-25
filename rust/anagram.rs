use std::collections::{HashMap, HashSet};

fn is_anagram(a: &str, b: &str) -> bool {
    let a = a.to_lowercase();
    if a == b {
        return false;
    }

    let mut h1 = HashMap::new();
    for c in a.chars() {
        *h1.entry(c).or_insert(0) += 1;
    }

    let mut h2 = HashMap::new();
    for c in b.chars() {
        *h2.entry(c).or_insert(0) += 1;
    }

    h1 == h2
}

pub fn anagrams_for<'a>(word: &str, possible_anagrams: &[&'a str]) -> HashSet<&'a str> {
    let word = word.to_lowercase();
    let mut set = HashSet::new();
    for &s in possible_anagrams {
        if is_anagram(s, &word) {
            set.insert(s);
        }
    }
    set
}
