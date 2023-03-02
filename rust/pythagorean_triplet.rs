pub fn find() -> Option<u32> {
    for a in 1..1000 {
        for b in 1..(1000 - a) {
            let c = 1000 - a - b;
            if c * c == a * a + b * b {
                return Some(a * b * c);
            }
        }
    }
    return None;
}
