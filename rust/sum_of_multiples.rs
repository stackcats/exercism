use std::collections::HashSet;

pub fn sum_of_multiples(limit: u32, factors: &[u32]) -> u32 {
    let mut set = HashSet::new();
    for &f in factors {
        if f == 0 {
            continue;
        }
        let mut g = f;
        while g < limit {
            set.insert(g);
            g += f;
        }
    }

    set.into_iter().sum()
}
