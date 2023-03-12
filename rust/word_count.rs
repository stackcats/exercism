use std::collections::HashMap;

/// Count occurrences of words.
pub fn word_count(words: &str) -> HashMap<String, u32> {
    let mut mp = HashMap::new();
    words
        .split(|c| !(char::is_alphanumeric(c) || c == '\''))
        .filter(|s| *s != "")
        .map(|s| s.to_lowercase().trim_matches('\'').to_string())
        .for_each(|s| {
            *mp.entry(s.to_string()).or_insert(0) += 1;
        });
    mp
}
