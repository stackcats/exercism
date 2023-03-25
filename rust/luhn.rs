/// Check a Luhn checksum.
pub fn is_valid(code: &str) -> bool {
    let code = code.replace(" ", "");
    if code.len() <= 1 {
        return false;
    }

    let mut is_even = false;
    let mut sum = 0;
    for c in code.chars().rev() {
        if !c.is_digit(10) {
            return false;
        }
        let mut n = c.to_digit(10).unwrap();
        if is_even {
            n = n * 2;
            if n >= 10 {
                n = n - 9;
            }
        }
        sum += n;
        is_even = !is_even;
    }
    sum % 10 == 0
}
