pub fn factors(mut n: u64) -> Vec<u64> {
    let mut arr = Vec::new();
    let mut i = 2;
    while n >= i {
        if n % i == 0 {
            arr.push(i);
            n /= i;
        } else {
            i += 1;
        }
    }
    arr
}
