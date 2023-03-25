pub fn is_armstrong_number(num: u32) -> bool {
    let digits = num.to_string().len() as u32;

    let mut n = num;
    let mut sum = 0;
    while n > 0 {
        let d = n % 10;
        let t = d.pow(digits);
        if u32::MAX - t < sum {
            return false;
        }
        sum += t;
        n /= 10;
    }

    sum == num
}
