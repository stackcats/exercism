pub fn square_of_sum(n: u32) -> u32 {
    let sum: u32 = (1..=n).into_iter().sum();
    sum * sum
}

pub fn sum_of_squares(n: u32) -> u32 {
    (1..=n).into_iter().map(|x| x * x).sum()
}

pub fn difference(n: u32) -> u32 {
    square_of_sum(n) - sum_of_squares(n)
}
