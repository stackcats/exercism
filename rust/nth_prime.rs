pub fn nth(mut n: u32) -> u32 {
    let mut primes = Vec::new();
    (2u32..)
        .filter(|x| {
            if primes.iter().any(|p| x % p == 0) {
                false
            } else {
                primes.push(*x);
                true
            }
        })
        .nth(n as usize)
        .unwrap()
}
